//
//  Atom.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

public enum Atom {
    case list([Atom])
    case text(String)
}
