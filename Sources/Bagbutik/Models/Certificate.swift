import Foundation

/**
 The data structure that represents a Certificates resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/certificate>
 */
public struct Certificate: Codable {
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    /// Navigational links that include the self-link.
    public let links: ResourceLinks
    /// The resource type.
    public var type: String { "certificates" }
    /// The resource's attributes.
    public let attributes: Attributes?

    public init(id: String, links: ResourceLinks, attributes: Attributes? = nil) {
        self.id = id
        self.links = links
        self.attributes = attributes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        links = try container.decode(ResourceLinks.self, forKey: .links)
        attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
        if try container.decode(String.self, forKey: .type) != type {
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(links, forKey: .links)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(attributes, forKey: .attributes)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case links
        case type
        case attributes
    }

    /**
     Attributes that describe a Certificates resource.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/certificate/attributes>
     */
    public struct Attributes: Codable {
        public var certificateContent: String?
        @NullCodable public var certificateType: CertificateType?
        public var displayName: String?
        public var expirationDate: Date?
        public var name: String?
        @NullCodable public var platform: BundleIdPlatform?
        public var serialNumber: String?

        public init(certificateContent: String? = nil, certificateType: CertificateType? = nil, displayName: String? = nil, expirationDate: Date? = nil, name: String? = nil, platform: BundleIdPlatform? = nil, serialNumber: String? = nil) {
            self.certificateContent = certificateContent
            self.certificateType = certificateType
            self.displayName = displayName
            self.expirationDate = expirationDate
            self.name = name
            self.platform = platform
            self.serialNumber = serialNumber
        }
    }
}
