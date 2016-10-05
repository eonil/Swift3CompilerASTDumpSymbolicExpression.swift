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
        case quoting(Character)
    }
    var allTokens = [Token]()
    var tokenConstruction = ""
    var quoting = QuotingState.none

    func commitCurrentTokenConstructionIfAvailableAndReset() {
        guard tokenConstruction.isEmpty == false else { return }
        allTokens.append(.text(tokenConstruction))
        tokenConstruction = ""
    }
    func processQuote(_ ch: Character) {
        switch quoting {
        case .none:
            quoting = .quoting(ch)
            tokenConstruction.append(ch)
        case .quoting(let ch1):
            if ch1 == ch {
                quoting = .none
            }
            tokenConstruction.append(ch)
        }
    }
    for ch in code.characters {
        switch quoting {
        case .none:
            switch ch {
            case "'", "\"":
                processQuote(ch)
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
        case .quoting:
            switch ch {
            case "'", "\"":
                processQuote(ch)
            default:
                tokenConstruction.append(ch)
            }
        }
    }
    commitCurrentTokenConstructionIfAvailableAndReset()
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
