public extension Request {
    /**
      # Modify an App Clip Invocation You Provide to Testers
      Change an App Clip invocation you make available to testers in the TestFlight app.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_clip_invocation_you_provide_to_testers>

      - Parameter id: The id of the requested resource
      - Parameter requestBody: BetaAppClipInvocation representation
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func updateBetaAppClipInvocation(id: String,
                                            requestBody: BetaAppClipInvocationUpdateRequest) -> Request<BetaAppClipInvocationResponse, ErrorResponse>
    {
        return .init(path: "/v1/betaAppClipInvocations/\(id)", method: .patch, requestBody: requestBody)
    }
}
