import Foundation
import XCTest
@testable import Swift3CompilerASTDumpSymbolicExpression

class Swift3CompilerASTDumpSymbolicExpressionTests: XCTestCase {
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        XCTAssertEqual(Swift3CompilerASTDumpSymbolicExpression().text, "Hello, World!")
//    }

    func test1() throws {
        // Dirty hack.
        // This requires access grant to source location in testing.
        // Because we have no way to include resource for test target using SwiftPM for now...
        let f = #file
        let f1 = URL(fileURLWithPath: f)
        let f2 = f1.deletingLastPathComponent().appendingPathComponent("sample-swift3-ast-dump1")
        let dump = String(data: try Data(contentsOf: f2), encoding: .utf8)!
        let sxpr = Swift3CompilerASTDumpSymbolicExpression.parse(code: dump)
        switch sxpr {
        case .list(let l):
            XCTAssert(l.count > 0)
        case .text(_):
            XCTFail()
        }
    }

    func test2() throws {
        let a = "(enum_decl \"E1\" type='E1.Type' access=internal @_fixed_layout)"
        let b = tokenize(code: a)
        XCTAssert(b.count == 11)
        let c = analyze(tokens: b)
        XCTAssert(c.text == "")
        XCTAssert(c.children.count == 5)
        XCTAssert(c.children[0].text == "enum_decl")
        XCTAssert(c.children[4].text == "@_fixed_layout")
        let d = organize(ast: c)
        switch d {
        case .list(let a):
            XCTAssert(a.count == 5)
            switch a[0] {
            case .list(_):
                XCTFail()
            case .text(let s):
                XCTAssert(s == "enum_decl")
            }
            switch a[4] {
            case .list(_):
                XCTFail()
            case .text(let s):
                XCTAssert(s == "@_fixed_layout")
            }
        case .text(_):
            XCTFail()
        }
    }

    static var allTests : [(String, (Swift3CompilerASTDumpSymbolicExpressionTests) -> () throws -> Void)] {
        return [
            ("test1", test1),
            ("test2", test2),
        ]
    }
}
