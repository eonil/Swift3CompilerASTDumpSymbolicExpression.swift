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

    static var allTests : [(String, (Swift3CompilerASTDumpSymbolicExpressionTests) -> () throws -> Void)] {
        return [
            ("test1", test1),
        ]
    }
}
