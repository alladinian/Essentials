import XCTest
@testable import Essentials

final class EssentialsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Essentials().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
