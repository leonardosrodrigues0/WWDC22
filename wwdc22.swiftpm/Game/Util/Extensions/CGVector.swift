import UIKit

extension CGVector {

    init(pointA: CGPoint, pointB: CGPoint) {
        self.init(
            dx: pointB.x - pointA.x,
            dy: pointB.y - pointA.y
        )
    }

    var magnitude: CGFloat {
        sqrt(pow(dx, 2) + pow(dy, 2))
    }

    var orientation: CGFloat {
        atan2(dy, dx)
    }
}
