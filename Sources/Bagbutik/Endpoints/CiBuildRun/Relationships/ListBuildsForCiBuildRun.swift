public extension Request {
    /**
      # List All Builds Xcode Cloud Created in App Store Connect
      List All App Store Connect and TestFlight Builds when it performed a build.

      Full documentation:
      <https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_xcode_cloud_created_in_app_store_connect>

      - Parameter id: The id of the requested resource
      - Parameter fields: Fields to return for included related types
      - Parameter filters: Attributes, relationships, and IDs by which to filter
      - Parameter includes: Relationship data to include in the response
      - Parameter sorts: Attributes by which to sort
      - Parameter limits: Number of resources to return
      - Returns: A `Request` with to send to an instance of `BagbutikService`
     */
    static func listBuildsForCiBuildRun(id: String,
                                        fields: [ListBuildsForCiBuildRun.Field]? = nil,
                                        filters: [ListBuildsForCiBuildRun.Filter]? = nil,
                                        includes: [ListBuildsForCiBuildRun.Include]? = nil,
                                        sorts: [ListBuildsForCiBuildRun.Sort]? = nil,
                                        limits: [ListBuildsForCiBuildRun.Limit]? = nil) -> Request<BuildsResponse, ErrorResponse>
    {
        return .init(path: "/v1/ciBuildRuns/\(id)/builds", method: .get, parameters: .init(fields: fields,
                                                                                           filters: filters,
                                                                                           includes: includes,
                                                                                           sorts: sorts,
                                                                                           limits: limits))
    }
}

public enum ListBuildsForCiBuildRun {
    /**
     Fields to return for included related types.
     */
    public enum Field: FieldParameter {
        /// The fields to include for returned resources of type appEncryptionDeclarations
        case appEncryptionDeclarations([AppEncryptionDeclarations])
        /// The fields to include for returned resources of type appStoreVersions
        case appStoreVersions([AppStoreVersions])
        /// The fields to include for returned resources of type apps
        case apps([Apps])
        /// The fields to include for returned resources of type betaAppReviewSubmissions
        case betaAppReviewSubmissions([BetaAppReviewSubmissions])
        /// The fields to include for returned resources of type betaBuildLocalizations
        case betaBuildLocalizations([BetaBuildLocalizations])
        /// The fields to include for returned resources of type betaGroups
        case betaGroups([BetaGroups])
        /// The fields to include for returned resources of type betaTesters
        case betaTesters([BetaTesters])
        /// The fields to include for returned resources of type buildBetaDetails
        case buildBetaDetails([BuildBetaDetails])
        /// The fields to include for returned resources of type buildBundles
        case buildBundles([BuildBundles])
        /// The fields to include for returned resources of type buildIcons
        case buildIcons([BuildIcons])
        /// The fields to include for returned resources of type builds
        case builds([Builds])
        /// The fields to include for returned resources of type preReleaseVersions
        case preReleaseVersions([PreReleaseVersions])

        public enum AppEncryptionDeclarations: String, ParameterValue, CaseIterable {
            case app
            case appEncryptionDeclarationState
            case availableOnFrenchStore
            case builds
            case codeValue
            case containsProprietaryCryptography
            case containsThirdPartyCryptography
            case documentName
            case documentType
            case documentUrl
            case exempt
            case platform
            case uploadedDate
            case usesEncryption
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

        public enum BetaAppReviewSubmissions: String, ParameterValue, CaseIterable {
            case betaReviewState
            case build
            case submittedDate
        }

        public enum BetaBuildLocalizations: String, ParameterValue, CaseIterable {
            case build
            case locale
            case whatsNew
        }

        public enum BetaGroups: String, ParameterValue, CaseIterable {
            case app
            case betaTesters
            case builds
            case createdDate
            case feedbackEnabled
            case hasAccessToAllBuilds
            case iosBuildsAvailableForAppleSiliconMac
            case isInternalGroup
            case name
            case publicLink
            case publicLinkEnabled
            case publicLinkId
            case publicLinkLimit
            case publicLinkLimitEnabled
        }

        public enum BetaTesters: String, ParameterValue, CaseIterable {
            case apps
            case betaGroups
            case builds
            case email
            case firstName
            case inviteType
            case lastName
        }

        public enum BuildBetaDetails: String, ParameterValue, CaseIterable {
            case autoNotifyEnabled
            case build
            case externalBuildState
            case internalBuildState
        }

        public enum BuildBundles: String, ParameterValue, CaseIterable {
            case appClipDomainCacheStatus
            case appClipDomainDebugStatus
            case betaAppClipInvocations
            case buildBundleFileSizes
            case bundleId
            case bundleType
            case dSYMUrl
            case deviceProtocols
            case entitlements
            case fileName
            case hasOnDemandResources
            case hasPrerenderedIcon
            case hasSirikit
            case includesSymbols
            case isIosBuildMacAppStoreCompatible
            case locales
            case platformBuild
            case requiredCapabilities
            case sdkBuild
            case supportedArchitectures
            case usesLocationServices
        }

        public enum BuildIcons: String, ParameterValue, CaseIterable {
            case iconAsset
            case iconType
            case name
        }

        public enum Builds: String, ParameterValue, CaseIterable {
            case app
            case appEncryptionDeclaration
            case appStoreVersion
            case betaAppReviewSubmission
            case betaBuildLocalizations
            case betaGroups
            case buildAudienceType
            case buildBetaDetail
            case buildBundles
            case computedMinMacOsVersion
            case diagnosticSignatures
            case expirationDate
            case expired
            case iconAssetToken
            case icons
            case individualTesters
            case lsMinimumSystemVersion
            case minOsVersion
            case perfPowerMetrics
            case preReleaseVersion
            case processingState
            case uploadedDate
            case usesNonExemptEncryption
            case version
        }

        public enum PreReleaseVersions: String, ParameterValue, CaseIterable {
            case app
            case builds
            case platform
            case version
        }
    }

    /**
     Attributes, relationships, and IDs by which to filter.
     */
    public enum Filter: FilterParameter {
        /// Filter by id(s) of related 'app'
        case app([String])
        /// Filter by id(s) of related 'appStoreVersion'
        case appStoreVersion([String])
        /// Filter by attribute 'betaAppReviewSubmission.betaReviewState'
        case betaAppReviewSubmission_betaReviewState([BetaAppReviewSubmissionBetaReviewState])
        /// Filter by id(s) of related 'betaGroups'
        case betaGroups([String])
        /// Filter by attribute 'buildAudienceType'
        case buildAudienceType([BuildAudienceType])
        /// Filter by attribute 'expired'
        case expired([String])
        /// Filter by id(s)
        case id([String])
        /// Filter by id(s) of related 'preReleaseVersion'
        case preReleaseVersion([String])
        /// Filter by attribute 'preReleaseVersion.platform'
        case preReleaseVersion_platform([PreReleaseVersionPlatform])
        /// Filter by attribute 'preReleaseVersion.version'
        case preReleaseVersion_version([String])
        /// Filter by attribute 'processingState'
        case processingState([ProcessingState])
        /// Filter by attribute 'usesNonExemptEncryption'
        case usesNonExemptEncryption([String])
        /// Filter by attribute 'version'
        case version([String])

        public enum BetaAppReviewSubmissionBetaReviewState: String, ParameterValue, CaseIterable {
            case waitingForReview = "WAITING_FOR_REVIEW"
            case inReview = "IN_REVIEW"
            case rejected = "REJECTED"
            case approved = "APPROVED"
        }

        public enum BuildAudienceType: String, ParameterValue, CaseIterable {
            case internalOnly = "INTERNAL_ONLY"
            case appStoreEligible = "APP_STORE_ELIGIBLE"
        }

        public enum PreReleaseVersionPlatform: String, ParameterValue, CaseIterable {
            case iOS = "IOS"
            case macOS = "MAC_OS"
            case tvOS = "TV_OS"
        }

        public enum ProcessingState: String, ParameterValue, CaseIterable {
            case processing = "PROCESSING"
            case failed = "FAILED"
            case invalid = "INVALID"
            case valid = "VALID"
        }
    }

    /**
     Relationship data to include in the response.
     */
    public enum Include: String, IncludeParameter {
        case app, appEncryptionDeclaration, appStoreVersion, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, buildBundles, icons, individualTesters, preReleaseVersion
    }

    /**
     Attributes by which to sort.
     */
    public enum Sort: String, SortParameter {
        case preReleaseVersionAscending = "preReleaseVersion"
        case preReleaseVersionDescending = "-preReleaseVersion"
        case uploadedDateAscending = "uploadedDate"
        case uploadedDateDescending = "-uploadedDate"
        case versionAscending = "version"
        case versionDescending = "-version"
    }

    /**
     Number of included related resources to return.
     */
    public enum Limit: LimitParameter {
        /// Maximum resources per page - maximum 200
        case limit(Int)
        /// Maximum number of related individualTesters returned (when they are included) - maximum 50
        case individualTesters(Int)
        /// Maximum number of related betaGroups returned (when they are included) - maximum 50
        case betaGroups(Int)
        /// Maximum number of related betaBuildLocalizations returned (when they are included) - maximum 50
        case betaBuildLocalizations(Int)
        /// Maximum number of related icons returned (when they are included) - maximum 50
        case icons(Int)
        /// Maximum number of related buildBundles returned (when they are included) - maximum 50
        case buildBundles(Int)
    }
}
