import SpriteKit
import GameplayKit

struct Level {
    init(_ build: @autoclosure @escaping () -> [GKEntity]) {
        self.build = build
    }

    let build: () -> [GKEntity]
}

extension Level {
    static var baseWallThickness: CGFloat { 40 }

    static func buildLevels(scene: GameScene) -> [Level] {
        let height = scene.size.height
        let width = scene.size.width
        return [
            Level(
                [
                    FieldManager(scene: scene),
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Charge(position: CGPoint(
                        x: width / 3,
                        y: height / 2
                    ), type: .charge2),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    ))
                ]
            ),
            Level(
                [
                    FieldManager(scene: scene),
                    Charge(position: CGPoint(
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
            ),
            Level(
                [
                    FieldManager(scene: scene),
                    Charge(position: CGPoint(
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
            ),
            Level(
                [
                    FieldManager(scene: scene),
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Wall(CGPoint(
                        x: width / 3,
                        y: height
                    ), CGPoint(
                        x: width / 3,
                        y: 2 * height / 5
                    )),
                    Wall(CGPoint(
                        x: width / 3,
                        y: 2 * height / 5
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 5
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 5
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 3
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 3
                    ), CGPoint(
                        x: width / 2,
                        y: 2 * height / 3
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 5,
                        y: 8 * height / 15
                    ))
                ]
            )
        ]
    }
}
