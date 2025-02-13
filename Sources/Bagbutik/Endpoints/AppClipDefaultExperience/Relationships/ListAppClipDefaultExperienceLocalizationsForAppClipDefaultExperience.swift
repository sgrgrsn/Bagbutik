public extension Request {
    /**
      # Read Localization Information for a Default App Clip Experience
      Get localized metadata that appears on the App Clip card for a specific default App Clip experience.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/read_localization_information_for_a_default_app_clip_experience>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter includes: Relationship data to include in the response
      - Parameter limit: Maximum resources per page - maximum 200
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listAppClipDefaultExperienceLocalizationsForAppClipDefaultExperience(id: String,
                                                                                     fields: [ListAppClipDefaultExperienceLocalizationsForAppClipDefaultExperience.Field]? = nil,
                                                                                     filters: [ListAppClipDefaultExperienceLocalizationsForAppClipDefaultExperience.Filter]? = nil,
                                                                                     includes: [ListAppClipDefaultExperienceLocalizationsForAppClipDefaultExperience.Include]? = nil,
                                                                                     limit: Int? = nil) -> Request<AppClipDefaultExperienceLocalizationsResponse, ErrorResponse>
    {
        return .init(path: "/v1/appClipDefaultExperiences/\(id)/appClipDefaultExperienceLocalizations", method: .get, parameters: .init(fields: fields,
                                                                                                                                        filters: filters,
                                                                                                                                        includes: includes,
                                                                                                                                        limit: limit))
    }
}

public enum ListAppClipDefaultExperienceLocalizationsForAppClipDefaultExperience {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appClipDefaultExperienceLocalizations
        case appClipDefaultExperienceLocalizations([AppClipDefaultExperienceLocalizations])
        /// The fields to include for returned resources of type appClipDefaultExperiences
        case appClipDefaultExperiences([AppClipDefaultExperiences])
        /// The fields to include for returned resources of type appClipHeaderImages
        case appClipHeaderImages([AppClipHeaderImages])

        public enum AppClipDefaultExperienceLocalizations: String, ParameterValue, CaseIterable {
            case appClipDefaultExperience
            case appClipHeaderImage
            case locale
            case subtitle
        }

        public enum AppClipDefaultExperiences: String, ParameterValue, CaseIterable {
            case action
            case appClip
            case appClipAppStoreReviewDetail
            case appClipDefaultExperienceLocalizations
            case appClipDefaultExperienceTemplate
            case releaseWithAppStoreVersion
        }

        public enum AppClipHeaderImages: String, ParameterValue, CaseIterable {
            case appClipDefaultExperienceLocalization
            case assetDeliveryState
            case fileName
            case fileSize
            case imageAsset
            case sourceFileChecksum
            case uploadOperations
            case uploaded
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by attribute 'locale'
        case locale([String])
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case appClipDefaultExperience, appClipHeaderImage
    }
}
