public extension Request {
    /**
      # No overview available

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/get_v1_appstoreversionexperiments_id>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter includes: Relationship data to include in the response
      - Parameter limit: Maximum number of related appStoreVersionExperimentTreatments returned (when they are included) - maximum 50
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func getAppStoreVersionExperiment(id: String,
                                             fields: [GetAppStoreVersionExperiment.Field]? = nil,
                                             includes: [GetAppStoreVersionExperiment.Include]? = nil,
                                             limit: Int? = nil) -> Request<AppStoreVersionExperimentResponse, ErrorResponse>
    {
        return .init(path: "/v1/appStoreVersionExperiments/\(id)", method: .get, parameters: .init(fields: fields,
                                                                                                   includes: includes,
                                                                                                   limit: limit))
    }
}

public enum GetAppStoreVersionExperiment {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appStoreVersionExperimentTreatments
        case appStoreVersionExperimentTreatments([AppStoreVersionExperimentTreatments])
        /// The fields to include for returned resources of type appStoreVersionExperiments
        case appStoreVersionExperiments([AppStoreVersionExperiments])

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
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case appStoreVersion, appStoreVersionExperimentTreatments
    }
}
