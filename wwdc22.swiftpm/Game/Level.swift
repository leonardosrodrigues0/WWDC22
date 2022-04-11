import SpriteKit
import GameplayKit

struct Level {
    let builder: () -> [GKEntity]
}

extension Level {
    static var baseWallThickness: CGFloat { 40 }

    static func buildLevels(width: CGFloat, height: CGFloat) -> [Level] {
        return [
//            Level {
//                [
//                    Ally(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    ))
//                ]
//            },
//            Level {
//                [
//                    Ally(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    )),
//                    NotAllowedWall(rect: CGRect(
//                        center: CGPoint(
//                            x: width / 2,
//                            y: height / 4
//                        ),
//                        size: CGSize(
//                            width: baseWallThickness,
//                            height: height / 2
//                        )
//                    ))
//                ]
//            },
//            Level {
//                [
//                    Ally(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    )),
//                    NotAllowedWall(rect: CGRect(
//                        center: CGPoint(
//                            x: 2 * width / 5,
//                            y: 3 * height / 4
//                        ),
//                        size: CGSize(
//                            width: baseWallThickness,
//                            height: height / 2
//                        )
//                    )),
//                    NotAllowedWall(rect: CGRect(
//                        center: CGPoint(
//                            x: 3 * width / 5,
//                            y: height / 4
//                        ),
//                        size: CGSize(
//                            width: baseWallThickness,
//                            height: height / 2
//                        )
//                    ))
//                ]
//            },
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
                    NotAllowedWall(CGPoint(
                        x: width / 2,
                        y: 3 * height / 4
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: height / 2
                    ))
                ]
            }
        ]
    }
}
