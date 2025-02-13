import Foundation

/**
 The request body you use to update an App Update.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest>
 */
public struct AppUpdateRequest: Codable, RequestBody {
    /// The resource data.
    public let data: Data
    /// The included related resources.
    @NullCodable public var included: [AppPriceInlineCreate]?

    public init(data: Data, included: [AppPriceInlineCreate]? = nil) {
        self.data = data
        self.included = included
    }

    /**
     The data element of the request body.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest/data>
     */
    public struct Data: Codable {
        /// The opaque resource ID that uniquely identifies the resource.
        public let id: String
        /// The resource type.
        public var type: String { "apps" }
        /// The resource's attributes.
        public let attributes: Attributes?
        /// The types and IDs of the related data to update.
        public let relationships: Relationships?

        public init(id: String, attributes: Attributes? = nil, relationships: Relationships? = nil) {
            self.id = id
            self.attributes = attributes
            self.relationships = relationships
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
            relationships = try container.decodeIfPresent(Relationships.self, forKey: .relationships)
            if try container.decode(String.self, forKey: .type) != type {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(type, forKey: .type)
            try container.encodeIfPresent(attributes, forKey: .attributes)
            try container.encodeIfPresent(relationships, forKey: .relationships)
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case attributes
            case relationships
        }

        /**
         Attributes whose values you're changing as part of the update request.

         Full documentation:
         <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest/data/attributes>
         */
        public struct Attributes: Codable {
            public var availableInNewTerritories: Bool?
            public var bundleId: String?
            @NullCodable public var contentRightsDeclaration: App.Attributes.ContentRightsDeclaration?
            public var primaryLocale: String?
            public var subscriptionStatusUrl: String?
            public var subscriptionStatusUrlForSandbox: String?
            @NullCodable public var subscriptionStatusUrlVersion: SubscriptionStatusUrlVersion?
            @NullCodable public var subscriptionStatusUrlVersionForSandbox: SubscriptionStatusUrlVersion?

            public init(availableInNewTerritories: Bool? = nil, bundleId: String? = nil, contentRightsDeclaration: App.Attributes.ContentRightsDeclaration? = nil, primaryLocale: String? = nil, subscriptionStatusUrl: String? = nil, subscriptionStatusUrlForSandbox: String? = nil, subscriptionStatusUrlVersion: SubscriptionStatusUrlVersion? = nil, subscriptionStatusUrlVersionForSandbox: SubscriptionStatusUrlVersion? = nil) {
                self.availableInNewTerritories = availableInNewTerritories
                self.bundleId = bundleId
                self.contentRightsDeclaration = contentRightsDeclaration
                self.primaryLocale = primaryLocale
                self.subscriptionStatusUrl = subscriptionStatusUrl
                self.subscriptionStatusUrlForSandbox = subscriptionStatusUrlForSandbox
                self.subscriptionStatusUrlVersion = subscriptionStatusUrlVersion
                self.subscriptionStatusUrlVersionForSandbox = subscriptionStatusUrlVersionForSandbox
            }
        }

        /**
         The data and links that describe the relationship between the resources.

         Full documentation:
         <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest/data/relationships>
         */
        public struct Relationships: Codable {
            @NullCodable public var availableTerritories: AvailableTerritories?
            @NullCodable public var prices: Prices?

            public init(availableTerritories: AvailableTerritories? = nil, prices: Prices? = nil) {
                self.availableTerritories = availableTerritories
                self.prices = prices
            }

            public struct AvailableTerritories: Codable {
                /// The type and ID of a resource that you're relating with the resource you're updating.
                @NullCodable public var data: [Data]?

                public init(data: [Data]? = nil) {
                    self.data = data
                }

                /**
                 The type and ID of a resource that you're relating with the resource you're updating.

                 Full documentation:
                 <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest/data/relationships/availableterritories/data>
                 */
                public struct Data: Codable {
                    /// The opaque resource ID that uniquely identifies the resource.
                    public let id: String
                    /// The resource type.
                    public var type: String { "territories" }

                    public init(id: String) {
                        self.id = id
                    }

                    public init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        id = try container.decode(String.self, forKey: .id)
                        if try container.decode(String.self, forKey: .type) != type {
                            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
                        }
                    }

                    public func encode(to encoder: Encoder) throws {
                        var container = encoder.container(keyedBy: CodingKeys.self)
                        try container.encode(id, forKey: .id)
                        try container.encode(type, forKey: .type)
                    }

                    private enum CodingKeys: String, CodingKey {
                        case id
                        case type
                    }
                }
            }

            public struct Prices: Codable {
                /// The type and ID of a resource that you're relating with the resource you're updating.
                @NullCodable public var data: [Data]?

                public init(data: [Data]? = nil) {
                    self.data = data
                }

                /**
                 The type and ID of a resource that you're relating with the resource you're updating.

                 Full documentation:
                 <https://developer.apple.com/documentation/appstoreconnectapi/appupdaterequest/data/relationships/prices/data>
                 */
                public struct Data: Codable {
                    /// The opaque resource ID that uniquely identifies the resource.
                    public let id: String
                    /// The resource type.
                    public var type: String { "appPrices" }

                    public init(id: String) {
                        self.id = id
                    }

                    public init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        id = try container.decode(String.self, forKey: .id)
                        if try container.decode(String.self, forKey: .type) != type {
                            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
                        }
                    }

                    public func encode(to encoder: Encoder) throws {
                        var container = encoder.container(keyedBy: CodingKeys.self)
                        try container.encode(id, forKey: .id)
                        try container.encode(type, forKey: .type)
                    }

                    private enum CodingKeys: String, CodingKey {
                        case id
                        case type
                    }
                }
            }
        }
    }
}
