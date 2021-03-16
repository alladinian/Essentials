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

        XCTAssertEqual(Optional<[String]>.none.orEmpty, [])
        XCTAssertEqual(Optional.some([1, 2, 3]).orEmpty, [1, 2, 3])

        let a = [1, 2, 3]
        XCTAssertEqual(a.elementAfter(2), 3)
        XCTAssertNil(a.elementAfter(3))
        XCTAssertNil(a.elementAfter(4))
        XCTAssertEqual(a.elementAfter(3, cycle: true), 1)

        XCTAssertEqual(a.elementBefore(2), 1)
        XCTAssertNil(a.elementBefore(1))
        XCTAssertNil(a.elementBefore(4))
        XCTAssertEqual(a.elementBefore(1, cycle: true), 3)
    }

    func testDate() {
        let date = Date(timeIntervalSince1970: 1612732663)

        XCTAssertEqual(date.day, 07)
        XCTAssertEqual(date.month, 02)
        XCTAssertEqual(date.year, 2021)
        XCTAssertEqual(date.nextMonth?.month, 03)
        XCTAssertEqual(date.previousMonth?.month, 01)
        XCTAssertEqual(date.startOfMonth?.day, 01)
        XCTAssertEqual(date.endOfMonth?.day, 28)
    }

    func testString() {
        XCTAssertTrue(Optional.some("").isNullOrEmpty)
        XCTAssertTrue(Optional<String>.none.isNullOrEmpty)
        XCTAssertFalse(Optional.some("a").isNullOrEmpty)

        XCTAssertEqual(Optional.some("").or("a"), "a")
        XCTAssertEqual(Optional<String>.none.or("a"), "a")
        XCTAssertEqual(Optional.some("b").or("a"), "b")

        XCTAssertEqual(" some ".trimmed, "some")
        XCTAssertEqual(" some".trimmed, "some")
        XCTAssertEqual("\nsome".trimmed, "some")

        XCTAssertEqual("some".capitalizingFirstLetter(), "Some")
        XCTAssertEqual("Some".lowercasingFirstLetter(), "some")

        XCTAssertEqual("some".transliterated, "σομε")

        XCTAssertEqual("3.14".decimalValue, 3.14)

        XCTAssertEqual("3.14".toBase64(), "My4xNA==")

        XCTAssertTrue("some@some.com".isValidEmail)
        XCTAssertFalse("some@some".isValidEmail)
        XCTAssertFalse("@some.com".isValidEmail)
        XCTAssertFalse("some..@some.com".isValidEmail)

        XCTAssertTrue("123456789".isValidPhone)
        XCTAssertTrue("+30123456789".isValidPhone)
        XCTAssertFalse("+30123456789a".isValidPhone)

        XCTAssertTrue("123".doesNotContain("4"))
        XCTAssertFalse("123".doesNotContain("ab2"))

        XCTAssertTrue("1".containsText)
        XCTAssertFalse("".containsText)
        XCTAssertFalse(" ".containsText)
        XCTAssertTrue("1".isNotEmpty)
    }

    func testGlobal() {
        let main = XCTestExpectation(description: "main")

        onMain {
            XCTAssertTrue(Thread.isMainThread)
            main.fulfill()
        }

        wait(for: [main], timeout: 1)
    }

    func testOperators() {
        XCTAssertEqual([" 1", "2", " 3 "].map(^\.trimmed), ["1", "2", "3"])
    }

    static var allTests = [
        ("testBool", testBool),
    ]
}
