import Foundation

enum PhysicsType: UInt32 {
    case ally = 1
    case allowedWall = 2
    case notAllowedWall = 4
    case goal = 8

    static var deathMask: UInt32 {
        PhysicsType.ally.rawValue | PhysicsType.notAllowedWall.rawValue
    }

    static var finishMask: UInt32 {
        PhysicsType.ally.rawValue | PhysicsType.goal.rawValue
    }
}
