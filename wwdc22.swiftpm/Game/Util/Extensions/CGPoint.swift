import UIKit

extension CGPoint {

    func midPoint(to point: CGPoint) -> CGPoint {
        CGPoint(
            x: (self.x + point.x) / 2,
            y: (self.y + point.y) / 2
        )
    }

    func distance(to point: CGPoint) -> CGFloat {
        let vector = CGVector(pointA: self, pointB: point)
        return vector.magnitude
    }
}
