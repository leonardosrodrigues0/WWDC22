import Foundation

enum Direction {
    case left
    case right

    var value: Int {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        }
    }
}
