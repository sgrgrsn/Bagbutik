public extension Request {
    /**
      # No overview available

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/patch_v1_appstoreversionexperiments_id>

      - Parameter id: The id of the requested resource
      - Parameter requestBody: AppStoreVersionExperiment representation
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateAppStoreVersionExperiment(id: String,
                                                requestBody: AppStoreVersionExperimentUpdateRequest) -> Request<AppStoreVersionExperimentResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreVersionExperiments/\(id)", method: .patch, requestBody: requestBody)
    }
}
