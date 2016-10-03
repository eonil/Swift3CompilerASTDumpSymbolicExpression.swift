//
//  organize.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

func organize(ast: SymbolicExpressionAST) -> Atom {
    if ast.text == "" {
        precondition(ast.text.isEmpty)
        return .list(ast.children.map(organize))
    }
    else {
        precondition(ast.children.isEmpty)
        return .text(ast.text)
    }
}


