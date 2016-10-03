//
//  tokenize.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

func tokenize(code: String) -> [Token] {
    enum QuotingState {
        case none
        case singleQuoting
    }
    var allTokens = [Token]()
    var tokenConstruction = ""
    var quoting = QuotingState.none

    func commitCurrentTokenConstructionIfAvailableAndReset() {
        guard tokenConstruction.isEmpty == false else { return }
        allTokens.append(.text(tokenConstruction))
        tokenConstruction = ""
    }
    func processSingleQuote() {
        switch quoting {
        case .none:
            quoting = .singleQuoting
            tokenConstruction.append("'")
        case .singleQuoting:
            quoting = .none
            tokenConstruction.append("'")
        }
    }

    for ch in code.characters {
        switch quoting {
        case .none:
            switch ch {
            case "'":
                processSingleQuote()
            case "(":
                commitCurrentTokenConstructionIfAvailableAndReset()
                allTokens.append(Token.punctuator("("))
            case ")":
                commitCurrentTokenConstructionIfAvailableAndReset()
                allTokens.append(Token.punctuator(")"))
            case "\n", "\t", " ":
                commitCurrentTokenConstructionIfAvailableAndReset()
                allTokens.append(.whitespace)
            default:
                tokenConstruction.append(ch)
            }
        case .singleQuoting:
            switch ch {
            case "'":
                processSingleQuote()
            default:
                tokenConstruction.append(ch)
            }
        }
    }
    return concatWhitespaceTokens(tokens: allTokens)
}

private func concatWhitespaceTokens(tokens: [Token]) -> [Token] {
    var newTokens = [Token]()
    var isLastWhitespace = false
    for tk in tokens {
        switch tk {
        case .whitespace:
            if isLastWhitespace == false {
                newTokens.append(tk)
            }
            isLastWhitespace = true
        default:
            isLastWhitespace = false
            newTokens.append(tk)
        }
    }
    return newTokens
}
