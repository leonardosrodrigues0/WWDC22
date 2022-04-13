import GameplayKit

class FieldManager: GKEntity {

    private var fields: [UITouch: Field]
    private let convergent: Bool
    weak var scene: GameScene!

    init(scene: GameScene, convergent: Bool = false) {
        self.scene = scene
        self.convergent = convergent
        fields = [:]
        super.init()
        let labelNode = buildLabelNode()
        addComponent(GeometryComponent(node: labelNode))
    }

    private func buildLabelNode() -> SKSpriteNode {
        let imageName = convergent ? "touchneg" : "touchpos"
        let node = SKSpriteNode(imageNamed: imageName)
        node.position = CGPoint(x: 0.1 * scene.width, y: 0.8 * scene.height)
        node.size = CGSize(width: 180, height: 90)
        return node
    }

    // MARK: - Manage Touches

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let field = Field(convergent: convergent)
            fields[touch] = field
            field.updatePosition(touch.location(in: scene))
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
                field.updatePosition(touch.location(in: scene))
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
