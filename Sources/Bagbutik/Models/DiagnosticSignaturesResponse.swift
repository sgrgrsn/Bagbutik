import Foundation

/**
 A response that contains a list of Diagnostic Signature resources.

 Full documentation:
 <https://developer.apple.com/documentation/appstoreconnectapi/diagnosticsignaturesresponse>
 */
public struct DiagnosticSignaturesResponse: Codable, PagedResponse {
    public typealias Data = DiagnosticSignature
    /// The resource data.
    public let data: [DiagnosticSignature]
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    /// Paging information.
    @NullCodable public var meta: PagingInformation?

    public init(data: [DiagnosticSignature], links: PagedDocumentLinks, meta: PagingInformation? = nil) {
        self.data = data
        self.links = links
        self.meta = meta
    }
}
