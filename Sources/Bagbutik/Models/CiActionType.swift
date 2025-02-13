import Foundation

/// A string that represents the type of an Xcode Cloud workflow’s action.
public enum CiActionType: String, Codable, CaseIterable {
    /// The action is a build action.
    case build = "BUILD"
    /// The action is an analyze action.
    case analyze = "ANALYZE"
    /// The action is a test action.
    case test = "TEST"
    /// The action is an archive action.
    case archive = "ARCHIVE"
}
