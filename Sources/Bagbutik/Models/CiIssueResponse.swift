import Foundation

/**
 A response that contains a single Issues resource.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/ciissueresponse>
 */
public struct CiIssueResponse: Codable {
    /// The resource data.
    public let data: CiIssue
    /// Navigational links that include the self-link.
    public let links: DocumentLinks

    public init(data: CiIssue, links: DocumentLinks) {
        self.data = data
        self.links = links
    }
}
