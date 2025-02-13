public extension Request {
    /**
      # List All Apps for a Beta Tester
      Get a list of apps that a beta tester can test.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_apps_for_a_beta_tester>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter limit: Maximum resources per page - maximum 200
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listAppsForBetaTester(id: String,
                                      fields: [ListAppsForBetaTester.Field]? = nil,
                                      limit: Int? = nil) -> Request<AppsResponse, ErrorResponse>
    {
        return .init(path: "/v1/betaTesters/\(id)/apps", method: .get, parameters: .init(fields: fields,
                                                                                         limit: limit))
    }
}

public enum ListAppsForBetaTester {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type apps
        case apps([Apps])

        public enum Apps: String, ParameterValue, CaseIterable {
            case appClips
            case appCustomProductPages
            case appEvents
            case appInfos
            case appStoreVersions
            case availableInNewTerritories
            case availableTerritories
            case betaAppLocalizations
            case betaAppReviewDetail
            case betaGroups
            case betaLicenseAgreement
            case betaTesters
            case builds
            case bundleId
            case ciProduct
            case contentRightsDeclaration
            case endUserLicenseAgreement
            case gameCenterEnabledVersions
            case inAppPurchases
            case isOrEverWasMadeForKids
            case name
            case perfPowerMetrics
            case preOrder
            case preReleaseVersions
            case pricePoints
            case prices
            case primaryLocale
            case reviewSubmissions
            case sku
            case subscriptionStatusUrl
            case subscriptionStatusUrlForSandbox
            case subscriptionStatusUrlVersion
            case subscriptionStatusUrlVersionForSandbox
        }
    }
}
