public extension Request {
    /**
      # No overview available

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/get_v1_appstoreversions_id_appstoreversionexperiments>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter includes: Relationship data to include in the response
      - Parameter limits: Number of resources to return
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listAppStoreVersionExperimentsForAppStoreVersion(id: String,
                                                                 fields: [ListAppStoreVersionExperimentsForAppStoreVersion.Field]? = nil,
                                                                 filters: [ListAppStoreVersionExperimentsForAppStoreVersion.Filter]? = nil,
                                                                 includes: [ListAppStoreVersionExperimentsForAppStoreVersion.Include]? = nil,
                                                                 limits: [ListAppStoreVersionExperimentsForAppStoreVersion.Limit]? = nil) -> Request<AppStoreVersionExperimentsResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreVersions/\(id)/appStoreVersionExperiments", method: .get, parameters: .init(fields: fields,
                                                                                                                    filters: filters,
                                                                                                                    includes: includes,
                                                                                                                    limits: limits))
    }
}

public enum ListAppStoreVersionExperimentsForAppStoreVersion {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appStoreVersionExperimentTreatments
        case appStoreVersionExperimentTreatments([AppStoreVersionExperimentTreatments])
        /// The fields to include for returned resources of type appStoreVersionExperiments
        case appStoreVersionExperiments([AppStoreVersionExperiments])
        /// The fields to include for returned resources of type appStoreVersions
        case appStoreVersions([AppStoreVersions])

        public enum AppStoreVersionExperimentTreatments: String, ParameterValue, CaseIterable {
            case appIcon
            case appIconName
            case appStoreVersionExperiment
            case appStoreVersionExperimentTreatmentLocalizations
            case name
            case promotedDate
        }

        public enum AppStoreVersionExperiments: String, ParameterValue, CaseIterable {
            case appStoreVersion
            case appStoreVersionExperimentTreatments
            case endDate
            case name
            case reviewRequired
            case startDate
            case started
            case state
            case trafficProportion
        }

        public enum AppStoreVersions: String, ParameterValue, CaseIterable {
            case ageRatingDeclaration
            case app
            case appClipDefaultExperience
            case appStoreReviewDetail
            case appStoreState
            case appStoreVersionExperiments
            case appStoreVersionLocalizations
            case appStoreVersionPhasedRelease
            case appStoreVersionSubmission
            case build
            case copyright
            case createdDate
            case downloadable
            case earliestReleaseDate
            case idfaDeclaration
            case platform
            case releaseType
            case routingAppCoverage
            case usesIdfa
            case versionString
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by attribute 'state'
        case state([State])

        public enum State: String, ParameterValue, CaseIterable {
            case prepareForSubmission = "PREPARE_FOR_SUBMISSION"
            case readyForReview = "READY_FOR_REVIEW"
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case accepted = "ACCEPTED"
            case approved = "APPROVED"
            case rejected = "REJECTED"
            case completed = "COMPLETED"
            case stopped = "STOPPED"
        }
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case appStoreVersion, appStoreVersionExperimentTreatments
    }

    /**
     Number of included related resources to return.
     */
    public enum Limit: LimitParameter {
        /// Maximum resources per page - maximum 200
        case limit(Int)
        /// Maximum number of related appStoreVersionExperimentTreatments returned (when they are included) - maximum 50
        case appStoreVersionExperimentTreatments(Int)
    }
}
