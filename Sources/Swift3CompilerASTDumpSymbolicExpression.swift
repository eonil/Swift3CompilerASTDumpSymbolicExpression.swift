//
//  Swift3CompilerASTDumpSymbolicExpression.swift
//  Swift3CompilerASTDumpSymbolicExpression
//
//  Created by Hoon H. on 2016/10/03.
//
//

public struct Swift3CompilerASTDumpSymbolicExpression {
    public static func parse(code: String) -> Atom {
        let tks = tokenize(code: code)
        let ast = analyze(tokens: tks)
        let sexpr = organize(ast: ast)
        return sexpr
    }
}
