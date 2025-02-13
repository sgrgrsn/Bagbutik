@testable import BagbutikSpecDecoder
import XCTest

final class OneOfOptionTests: XCTestCase {
    let jsonDecoder = JSONDecoder()

    func testDecodingSimple() throws {
        // Given
        let json = #"""
        [
            {
                "type" : "object",
                "title" : "SomeModel",
                "properties" : {
                    "name" : {
                        "type" : "string"
                    },
                    "vehicle" : {
                        "type" : "string",
                        "deprecated" : true
                    }
                }
            },
            {
                "$ref" : "#/components/schemas/AnotherModel"
            }
        ]
        """#
        // When
        let oneOfOptions = try jsonDecoder.decode([OneOfOption].self, from: json.data(using: .utf8)!)
        // Then
        guard case let .objectSchema(objectSchema) = oneOfOptions[0],
              case let .schemaRef(refName) = oneOfOptions[1]
        else { return XCTFail("") }
        XCTAssertEqual(oneOfOptions[0].schemaName, "SomeModel")
        XCTAssertEqual(objectSchema.name, "SomeModel")
        XCTAssertEqual(objectSchema.properties.count, 2)
        XCTAssertEqual(objectSchema.properties["name"]?.type.description, PropertyType.simple(.string).description)
        XCTAssertEqual(objectSchema.properties["vehicle"]?.type.description, PropertyType.simple(.string).description)
        XCTAssertEqual(objectSchema.properties["vehicle"]?.deprecated, true)
        XCTAssertEqual(oneOfOptions[1].schemaName, "AnotherModel")
        XCTAssertEqual(refName, "AnotherModel")
    }

    func testDecodingUnknownOption() throws {
        // Given
        let json = #"""
        {
            "unknown" : "invalid",
        }
        """#
        // When
        XCTAssertThrowsError(try jsonDecoder.decode(OneOfOption.self, from: json.data(using: .utf8)!)) {
            // Then
            guard case let .dataCorrupted(context) = $0 as! DecodingError else { return XCTFail() }
            XCTAssertEqual(context.codingPath.last?.stringValue, "type")
            XCTAssertEqual(context.debugDescription, "OneOf option not known")
        }
    }
}
