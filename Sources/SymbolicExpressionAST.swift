//
//  SymbolicExpressionAST.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

final class SymbolicExpressionAST {
    weak var parent: SymbolicExpressionAST?
    var text = ""
    var children = [SymbolicExpressionAST]()

    func totalCount() -> Int {
        return 1 + children.map({ $0.totalCount() }).reduce(0, +)
    }
    func stringify() -> String {
        if text.isEmpty == false {
            precondition(children.isEmpty)
            return text
        }
        else {
            precondition(text.isEmpty)
            return "(" + children.map({ $0.stringify() }).joined(separator: " ") + ")"
        }
    }
}
