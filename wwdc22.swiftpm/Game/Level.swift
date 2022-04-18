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
            GameLabel("Welcome", position: CGPoint(
                x: width / 2,
                y: 0.8 * height
            ), size: 120),
            Play(scene: scene, position: CGPoint(
                x: width / 2,
                y: 2 * height / 5
            ))
        ])
    }

    static func buildLevels(scene: GameScene) -> [Level] {
        let height = scene.size.height
        let width = scene.size.width
        return [
//            Level(
//                [
//                    GameLabel("Throw charges in the targets", position: CGPoint(
//                        x: width / 2,
//                        y: 0.95 * height
//                    )),
//                    Charge(position: CGPoint(
//                        x: 3 * width / 7,
//                        y: height / 2
//                    ), type: .charge1),
//                    Charge(position: CGPoint(
//                        x: 4 * width / 7,
//                        y: height / 2
//                    ), type: .charge2),
//                    Goal(position: CGPoint(
//                        x: 1 * width / 7,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 6 * width / 7,
//                        y: height / 2
//                    ))
//                ]
//            ),
//            Level(
//                [
//                    GameLabel("Closer interactions create stronger forces", position: CGPoint(
//                        x: width / 2,
//                        y: 0.95 * height
//                    )),
//                    Charge(position: CGPoint(
//                        x: 5 * width / 7,
//                        y: height / 2
//                    ), type: .charge1),
//                    Charge(position: CGPoint(
//                        x: 2.2 * width / 7,
//                        y: height / 2
//                    ), type: .charge2),
//                    Charge(position: CGPoint(
//                        x: 2 * width / 7,
//                        y: height / 2
//                    ), type: .charge3),
//                    Goal(position: CGPoint(
//                        x: 1 * width / 7,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 6 * width / 7,
//                        y: height / 2
//                    ))
//                ]
//            ),
//            Level(
//                [
//                    GameLabel("Touch to create electric fields and move charges", position: CGPoint(
//                        x: width / 2,
//                        y: 0.95 * height
//                    )),
//                    FieldManager(scene: scene, indicator: true),
//                    Charge(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    ))
//                ]
//            ),
//            Level(
//                [
//                    GameLabel("Attention to the type of field created", position: CGPoint(
//                        x: width / 2,
//                        y: 0.95 * height
//                    )),
//                    FieldManager(scene: scene, convergent: true, indicator: true),
//                    Charge(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    )),
//                    Wall(CGPoint(
//                        x: width / 2,
//                        y: 0
//                    ), CGPoint(
//                        x: width / 2,
//                        y: height / 2
//                    ))
//                ]
//            ),
//            Level(
//                [
//                    FieldManager(scene: scene),
//                    Charge(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    )),
//                    Wall(CGPoint(
//                        x: 2 * width / 5,
//                        y: height / 2
//                    ), CGPoint(
//                        x: 2 * width / 5,
//                        y: height
//                    )),
//                    Wall(CGPoint(
//                        x: 3 * width / 5,
//                        y: 0
//                    ), CGPoint(
//                        x: 3 * width / 5,
//                        y: height / 2
//                    ))
//                ]
//            ),
//            Level(
//                [
//                    GameLabel("Try 2 charges", position: CGPoint(
//                        x: width / 2,
//                        y: 0.95 * height
//                    )),
//                    FieldManager(scene: scene),
//                    Charge(position: CGPoint(
//                        x: width / 2,
//                        y: 2 * height / 3
//                    ), type: .charge1),
//                    Charge(position: CGPoint(
//                        x: width / 4,
//                        y: 1 * height / 3
//                    ), type: .charge2),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 4,
//                        y: height / 2
//                    )),
//                    Wall(CGPoint(
//                        x: 2 * width / 3,
//                        y: height
//                    ), CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 3
//                    )),
//                    Wall(CGPoint(
//                        x: 2 * width / 3,
//                        y: 1 * height / 3
//                    ), CGPoint(
//                        x: 2 * width / 3,
//                        y: 0
//                    ))
//                ]
//            ),
            Level(
                [
                    Charge(position: CGPoint(
                        x: width / 4,
                        y: 2 * height / 7
                    ), type: .charge1),
                    Charge(position: CGPoint(
                        x: 3 * width / 4,
                        y: 5 * height / 7
                    ), type: .charge2),
                    Goal(position: CGPoint(
                        x: width / 2,
                        y: height / 2
                    )),
//                    Wall(CGPoint(
//                        x: 0,
//                        y: 2 * height / 5
//                    ), CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 5
//                    )),
//                    Wall(CGPoint(
//                        x: 1 * width / 3,
//                        y: 3 * height / 5
//                    ), CGPoint(
//                        x: width,
//                        y: 3 * height / 5
//                    )),
                    Wall(CGPoint(
                        x: 1 * width / 5,
                        y: 1 * height / 5
                    ), CGPoint(
                        x: 4 * width / 5,
                        y: 1 * height / 5
                    )),
                    Wall(CGPoint(
                        x: 1 * width / 5,
                        y: 4 * height / 5
                    ), CGPoint(
                        x: 4 * width / 5,
                        y: 4 * height / 5
                    )),
                    FieldManager(scene: scene)
                ]
            ),
//            Level(
//                [
//                    FieldManager(scene: scene),
//                    Charge(position: CGPoint(
//                        x: width / 4,
//                        y: height / 2
//                    )),
//                    Wall(CGPoint(
//                        x: width / 3,
//                        y: height
//                    ), CGPoint(
//                        x: width / 3,
//                        y: 2 * height / 5
//                    )),
//                    Wall(CGPoint(
//                        x: width / 3,
//                        y: 2 * height / 5
//                    ), CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 5
//                    )),
//                    Wall(CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 5
//                    ), CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 3
//                    )),
//                    Wall(CGPoint(
//                        x: 2 * width / 3,
//                        y: 2 * height / 3
//                    ), CGPoint(
//                        x: width / 2,
//                        y: 2 * height / 3
//                    )),
//                    Goal(position: CGPoint(
//                        x: 3 * width / 5,
//                        y: 8 * height / 15
//                    ))
//                ]
//            )
        ]
    }
}
