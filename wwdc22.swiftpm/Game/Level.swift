import SpriteKit
import GameplayKit

struct Level {
    let builder: () -> [GKEntity]
}

extension Level {
    static var baseWallThickness: CGFloat { 40 }

    static func buildLevels(width: CGFloat, height: CGFloat) -> [Level] {
        return [
            Level {
                [
                    Ally(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    ))
                ]
            },
            Level {
                [
                    Ally(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    )),
                    Wall(CGPoint(
                        x: width / 2,
                        y: 0
                    ), CGPoint(
                        x: width / 2,
                        y: height / 2
                    ))
                ]
            },
            Level {
                [
                    Ally(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 5,
                        y: height / 2
                    ), CGPoint(
                        x: 2 * width / 5,
                        y: height
                    )),
                    Wall(CGPoint(
                        x: 3 * width / 5,
                        y: 0
                    ), CGPoint(
                        x: 3 * width / 5,
                        y: height / 2
                    ))
                ]
            },
            Level {
                [
                    Ally(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 5,
                        y: height
                    ), CGPoint(
                        x: 2 * width / 5,
                        y: height / 3
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 5,
                        y: height / 3
                    ), CGPoint(
                        x: 4 * width / 5,
                        y: height / 3
                    )),
                    Wall(CGPoint(
                        x: 4 * width / 5,
                        y: height / 3
                    ), CGPoint(
                        x: 4 * width / 5,
                        y: 3 * height / 4
                    )),
                    Wall(CGPoint(
                        x: 4 * width / 5,
                        y: 3 * height / 4
                    ), CGPoint(
                        x: 3 * width / 5,
                        y: 3 * height / 4
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: 6.5 * height / 12
                    ))
                ]
            }
        ]
    }
}
