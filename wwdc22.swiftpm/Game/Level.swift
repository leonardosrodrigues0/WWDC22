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

    static func menuLevel(scene: GameScene) -> Level {
        let height = scene.size.height
        let width = scene.size.width
        return Level([
            MenuChargeGenerator(scene: scene, position: CGPoint(
                x: width / 2,
                y: height / 2
            )),
            GameLabel("Field Control", position: CGPoint(
                x: width / 2,
                y: 0.85 * height
            ), scene: scene, size: 120, limitedSpace: false),
            GameLabel("Play with electric fields", position: CGPoint(
                x: width / 2,
                y: 0.3 * height
            ), scene: scene, size: 60, limitedSpace: false),
            Play(scene: scene, position: CGPoint(
                x: width / 2,
                y: height / 2
            ))
        ])
    }

    static func endLevel(scene: GameScene) -> Level {
        let height = scene.size.height
        let width = scene.size.width
        return Level([
            MenuChargeGenerator(scene: scene, position: CGPoint(
                x: width / 2,
                y: height / 2
            )),
            GameLabel("Thanks for playing", position: CGPoint(
                x: width / 2,
                y: 0.8 * height
            ), scene: scene, size: 80, limitedSpace: false),
            Return(scene: scene, position: CGPoint(
                x: width / 2,
                y: 2 * height / 5
            ))
        ])
    }

    static func buildLevels(scene: GameScene) -> [Level] {
        let height = scene.size.height
        let width = scene.size.width
        return [
            Level(
                [
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: height / 2
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    )),
                    FieldManager(scene: scene, indicator: true),
                    GameLabel("Touch to create electric fields and move charges", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            ),
            Level(
                [
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
                    )),
                    FieldManager(scene: scene, indicator: true),
                    GameLabel("Avoid the obstacles", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            ),
            Level(
                [
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
                    )),
                    FieldManager(scene: scene),
                    GameLabel("Tip: short touches create slower movement", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            ),
            Level(
                [
                    Charge(position: CGPoint(
                        x: width / 2,
                        y: 2 * height / 3
                    ), type: .charge1),
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: 1 * height / 3
                    ), type: .charge2),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 2
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 3,
                        y: height
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 3
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 3,
                        y: 1 * height / 3
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: 0
                    )),
                    FieldManager(scene: scene),
                    GameLabel("Try 2 charges", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            ),
            Level(
                [
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: height / 3
                    ), type: .charge1),
                    Charge(position: CGPoint(
                        x: 3 * width / 4,
                        y: height / 3
                    ), type: .charge2),
                    Goal(position: CGPoint(
                        x: width / 2,
                        y: height / 3
                    )),
                    Wall(CGPoint(
                        x: 2 * width / 3,
                        y: 0
                    ), CGPoint(
                        x: 2 * width / 3,
                        y: 2 * height / 3
                    )),
                    Wall(CGPoint(
                        x: 1 * width / 3,
                        y: 0
                    ), CGPoint(
                        x: 1 * width / 3,
                        y: 2 * height / 3
                    )),
                    FieldManager(scene: scene),
                    GameLabel("You can use more than 1 touch at the same time", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            ),
            Level(
                [
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
                    )),
                    FieldManager(scene: scene)
                ]
            ),
            Level(
                [
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: 3 * height / 8
                    ), type: .charge1),
                    Charge(position: CGPoint(
                        x: 3 * width / 4,
                        y: 5 * height / 8
                    ), type: .charge2),
                    Wall(CGPoint(
                        x: 0,
                        y: 3 * height / 4
                    ), CGPoint(
                        x: width,
                        y: 3 * height / 4
                    )),
                    Wall(CGPoint(
                        x: 0,
                        y: height / 4
                    ), CGPoint(
                        x: width,
                        y: height / 4
                    )),
                    Wall(CGPoint(
                        x: 0,
                        y: height / 2
                    ), CGPoint(
                        x: width,
                        y: height / 2
                    )),
                    Goal(position: CGPoint(
                        x: 3 * width / 4,
                        y: 3 * height / 8
                    )),
                    Goal(position: CGPoint(
                        x: width / 4,
                        y: 5 * height / 8
                    )),
                    FieldManager(scene: scene),
                    GameLabel("One last challenge", position: CGPoint(
                        x: width / 2,
                        y: 0.95 * height
                    ), scene: scene)
                ]
            )
        ]
    }
}
