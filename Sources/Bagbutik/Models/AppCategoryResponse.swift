import Foundation

/**
 A response that contains a single App Categories resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/appcategoryresponse>
 */
public struct AppCategoryResponse: Codable {
    /// The resource data.
    public let data: AppCategory
    /// The included related resources.
    @NullCodable public var included: [Included]?
    /// Navigational links that include the self-link.
    public let links: DocumentLinks

    public init(data: AppCategory, included: [Included]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }

    public enum Included: Codable {
        case appCategory(AppCategory)

        public init(from decoder: Decoder) throws {
            if let appCategory = try? AppCategory(from: decoder) {
                self = .appCategory(appCategory)
            } else {
                throw DecodingError.typeMismatch(Included.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                      debugDescription: "Unknown Included"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case let .appCategory(value):
                try value.encode(to: encoder)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type
        }
    }
}
