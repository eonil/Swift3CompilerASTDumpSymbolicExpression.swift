//
//  Token.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

enum Token {
    case punctuator(Character)
    case whitespace
    /// If this is came from quoted text, text contains the quotes.
    case text(String)
}
