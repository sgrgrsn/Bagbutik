public extension Request {
    /**
      # List All Git References for a Repository
      List all Git references for a specific repository that Xcode Cloud can access.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_git_references_for_a_repository>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter includes: Relationship data to include in the response
      - Parameter limit: Maximum resources per page - maximum 200
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listGitReferencesForScmRepository(id: String,
                                                  fields: [ListGitReferencesForScmRepository.Field]? = nil,
                                                  includes: [ListGitReferencesForScmRepository.Include]? = nil,
                                                  limit: Int? = nil) -> Request<ScmGitReferencesResponse, ErrorResponse>
    {
        return .init(path: "/v1/scmRepositories/\(id)/gitReferences", method: .get, parameters: .init(fields: fields,
                                                                                                      includes: includes,
                                                                                                      limit: limit))
    }
}

public enum ListGitReferencesForScmRepository {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type scmGitReferences
        case scmGitReferences([ScmGitReferences])
        /// The fields to include for returned resources of type scmRepositories
        case scmRepositories([ScmRepositories])

        public enum ScmGitReferences: String, ParameterValue, CaseIterable {
            case canonicalName
            case isDeleted
            case kind
            case name
            case repository
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

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case repository
    }
}
