public extension Request {
    /**
      # List All Source Code Management Providers
      List all source code management providers you connected to Xcode Cloud.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_source_code_management_providers>

      - Parameter fields: Fields to return for included related types
      - Parameter limit: Maximum resources per page - maximum 200
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listScmProviders(fields: [ListScmProviders.Field]? = nil,
                                 limit: Int? = nil) -> Request<ScmProvidersResponse, ErrorResponse>
    {
        return .init(path: "/v1/scmProviders", method: .get, parameters: .init(fields: fields,
                                                                               limit: limit))
    }
}

public enum ListScmProviders {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type scmProviders
        case scmProviders([ScmProviders])
        /// The fields to include for returned resources of type scmRepositories
        case scmRepositories([ScmRepositories])

        public enum ScmProviders: String, ParameterValue, CaseIterable {
            case repositories
            case scmProviderType
            case url
        }

        public enum ScmRepositories: String, ParameterValue, CaseIterable {
            case defaultBranch
            case gitReferences
            case httpCloneUrl
            case lastAccessedDate
            case ownerName
            case pullRequests
            case repositoryName
            case scmProvider
            case sshCloneUrl
        }
    }
}
