import Foundation

enum PhysicsType: UInt32, CaseIterable {
    case menuWall = 1
    case allowedWall = 2
    case notAllowedWall = 4
    case goal = 8
    case charge1 = 16
    case charge2 = 32
    case charge3 = 64
    case charge4 = 128

    static var chargesMask: UInt32 {
        Self.bitMask(for: [
            .charge1, .charge2, .charge3, .charge4
        ])
    }

    static func bitMask(for cases: [PhysicsType]) -> UInt32 {
        cases.reduce(0) { partialResult, type in
            partialResult | type.rawValue
        }
    }
}
