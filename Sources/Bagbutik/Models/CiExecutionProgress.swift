import Foundation

/// A string that represents the progress of an ongoing Xcode Cloud build.
public enum CiExecutionProgress: String, Codable, CaseIterable {
    /// Xcode Cloud hasn’t started the build.
    case pending = "PENDING"
    /// Xcode Cloud is performing the build.
    case running = "RUNNING"
    /// Xcode Cloud completed the build.
    case complete = "COMPLETE"
}
