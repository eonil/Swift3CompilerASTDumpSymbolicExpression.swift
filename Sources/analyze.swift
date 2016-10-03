//
//  analyze.swift
//  SwiftCompilerASTDumpSymbolicExpressionParser
//
//  Created by Hoon H. on 2016/10/03.
//
//

import Foundation

func analyze(tokens: [Token]) -> SymbolicExpressionAST {
    typealias AST = SymbolicExpressionAST
    let root = AST()
    var cur = root
    for tk in tokens {
        switch tk {
        case .punctuator(let ch):
            switch ch {
            case "(":
                let new = AST()
                cur.children.append(new)
                new.parent = cur
                cur = new
            case ")":
                precondition(cur.parent != nil)
                cur = cur.parent!
            default:
                fatalError()
            }
        case .whitespace:
            break
        case .text(let s):
            let new = AST()
            new.text = s
            cur.children.append(new)
        }
    }
    return root.children.first!
}

