import XCTest
@testable import Essentials

final class EssentialsTests: XCTestCase {

    func testBool() {
        XCTAssertEqual(true.asString, "true")
        XCTAssertEqual(false.asString, "false")
        XCTAssertEqual(true.asInt, 1)
        XCTAssertEqual(false.asInt, 0)
    }

    func testCollection() {
        XCTAssertEqual(["1", 2, true].toJSONString(pretty: false), "[\"1\",2,true]")
        XCTAssertEqual(["object": ["1", 2, true]].toJSONString(pretty: false), "{\"object\":[\"1\",2,true]}")

        XCTAssertEqual(["1", "2", "3"].commaSeparated, "1, 2, 3")
        XCTAssertEqual(["1", "", "3"].commaSeparated, "1, 3")
        XCTAssertEqual(["1", "", .some("3")].commaSeparated, "1, 3")

        XCTAssertEqual(["1", "3", "2", "10"].localizedStandardSorted(.orderedAscending), ["1", "2", "3", "10"])
        XCTAssertEqual(["1", "3", "2", "10"].localizedStandardSorted(.orderedDescending), ["1", "2", "3", "10"].reversed())

        let c: [String]? = nil
        XCTAssertEqual(c.orEmpty, [])
        XCTAssertEqual(Optional.some([1, 2, 3]).orEmpty, [1, 2, 3])

        let a = [1, 2, 3]
        XCTAssertEqual(a.after(2), 3)
        XCTAssertNil(a.after(3))
        XCTAssertNil(a.after(4))
        XCTAssertEqual(a.after(3, cycle: true), 1)

        XCTAssertEqual(a.before(2), 1)
        XCTAssertNil(a.before(1))
        XCTAssertNil(a.before(4))
        XCTAssertEqual(a.before(1, cycle: true), 3)
    }

    static var allTests = [
        ("testBool", testBool),
    ]
}
