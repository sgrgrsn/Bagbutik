import Foundation

/**
 A response that contains a single Routing App Coverages resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/routingappcoverageresponse>
 */
public struct RoutingAppCoverageResponse: Codable {
    /// The resource data.
    public let data: RoutingAppCoverage
    /// The included related resources.
    @NullCodable public var included: [AppStoreVersion]?
    /// Navigational links that include the self-link.
    public let links: DocumentLinks

    public init(data: RoutingAppCoverage, included: [AppStoreVersion]? = nil, links: DocumentLinks) {
        self.data = data
        self.included = included
        self.links = links
    }
}
