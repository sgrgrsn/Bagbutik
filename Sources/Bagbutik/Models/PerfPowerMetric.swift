import Foundation

/**
 The data structure that represents the Power and Performance Metrics resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/perfpowermetric>
 */
public struct PerfPowerMetric: Codable {
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    /// Navigational links that include the self-link.
    public let links: ResourceLinks
    /// The resource type.
    public var type: String { "perfPowerMetrics" }
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
     Attributes that describe a Power and Performance Metrics resource.

     Full documentation:
     <https://developer.apple.com/documentation/appstoreconnectapi/perfpowermetric/attributes>
     */
    public struct Attributes: Codable {
        public var deviceType: String?
        @NullCodable public var metricType: MetricType?
        @NullCodable public var platform: Platform?

        public init(deviceType: String? = nil, metricType: MetricType? = nil, platform: Platform? = nil) {
            self.deviceType = deviceType
            self.metricType = metricType
            self.platform = platform
        }

        public enum MetricType: String, Codable, CaseIterable {
            case disk = "DISK"
            case hang = "HANG"
            case battery = "BATTERY"
            case launch = "LAUNCH"
            case memory = "MEMORY"
            case animation = "ANIMATION"
            case termination = "TERMINATION"
        }

        /// Strings that represent Apple operating systems.
        public enum Platform: String, Codable, CaseIterable {
            /// A string that represents iOS.
            case iOS = "IOS"
        }
    }
}
