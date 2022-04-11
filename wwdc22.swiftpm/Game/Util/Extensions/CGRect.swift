import UIKit

extension CGRect {

    init(center: CGPoint, size: CGSize) {
        self.init(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }

    var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }

    var extendedAndRoundedPath: CGPath {
        let newRect = self.extended
        let radius = min(self.width, self.height) / 2
        let path = UIBezierPath(roundedRect: newRect, cornerRadius: radius).cgPath
        return path
    }

    fileprivate var extended: CGRect {
        if self.width < self.height {
            return CGRect(center: self.center, size: CGSize(
                width: self.width,
                height: self.height + self.width
            ))
        } else {
            return CGRect(center: self.center, size: CGSize(
                width: self.width + self.height,
                height: self.height
            ))
        }
    }
}
