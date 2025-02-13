public extension Request {
    /**
      # Read the App Clip Card Image
      Get the image that appears on the App Clip card of a default App Clip experience.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_clip_card_image>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter includes: Relationship data to include in the response
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func getAppClipHeaderImage(id: String,
                                      fields: [GetAppClipHeaderImage.Field]? = nil,
                                      includes: [GetAppClipHeaderImage.Include]? = nil) -> Request<AppClipHeaderImageResponse, ErrorResponse>
    {
        return .init(path: "/v1/appClipHeaderImages/\(id)", method: .get, parameters: .init(fields: fields,
                                                                                            includes: includes))
    }
}

public enum GetAppClipHeaderImage {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appClipHeaderImages
        case appClipHeaderImages([AppClipHeaderImages])

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
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case appClipDefaultExperienceLocalization
    }
}
