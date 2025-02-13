import Foundation

/// The string that represents the kind of a test destination.
public enum CiTestDestinationKind: String, Codable, CaseIterable {
    /// The test destination is a simulated device.
    case simulator = "SIMULATOR"
    /// The test destination is a Mac.
    case mac = "MAC"
}
