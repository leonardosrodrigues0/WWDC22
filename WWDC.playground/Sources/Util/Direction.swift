import Foundation

public enum Direction {
    case left
    case right

    public var value: Int {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        }
    }
}
