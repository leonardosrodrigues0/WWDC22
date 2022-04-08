import GameplayKit

class FieldManager: GKEntity {

    private var fields: [UITouch: GravityField]
    let scene: GameScene

    init(scene: GameScene) {
        self.scene = scene
        fields = [:]
        super.init()
    }

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let field = GravityField()
            fields[touch] = field
            field.component(
                ofType: GeometryComponent.self
            )?.node.position = touch.location(in: scene)
            scene.addEntity(field)
        }
    }

    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let field = fields[touch] {
                fields.removeValue(forKey: touch)
                scene.removeEntity(field)
            }
        }
    }

    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let field = fields[touch] {
                field.component(
                    ofType: GeometryComponent.self
                )?.node.position = touch.location(in: scene)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
