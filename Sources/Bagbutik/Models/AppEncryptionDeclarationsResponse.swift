import Foundation

/**
 A response that contains a list of App Encryption Declaration resources.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/appencryptiondeclarationsresponse>
 */
public struct AppEncryptionDeclarationsResponse: Codable, PagedResponse {
    public typealias Data = AppEncryptionDeclaration
    /// The resource data.
    public let data: [AppEncryptionDeclaration]
    /// The included related resources.
    @NullCodable public var included: [App]?
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    /// Paging information.
    @NullCodable public var meta: PagingInformation?

    public init(data: [AppEncryptionDeclaration], included: [App]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.included = included
        self.links = links
        self.meta = meta
    }
}
