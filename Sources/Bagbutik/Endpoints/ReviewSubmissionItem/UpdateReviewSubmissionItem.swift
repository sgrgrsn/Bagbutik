public extension Request {
    /**
      # No overview available

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/patch_v1_reviewsubmissionitems_id>

      - Parameter id: The id of the requested resource
      - Parameter requestBody: ReviewSubmissionItem representation
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateReviewSubmissionItem(id: String,
                                           requestBody: ReviewSubmissionItemUpdateRequest) -> Request<ReviewSubmissionItemResponse, ErrorResponse>
    {
        return .init(path: "/v1/reviewSubmissionItems/\(id)", method: .patch, requestBody: requestBody)
    }
}
