import GameplayKit

class FieldManager: GKEntity {

    private var fields: [UITouch: Field]
    private let convergent: Bool
    private let indicator: Bool
    weak var scene: GameScene!

    init(scene: GameScene, convergent: Bool = false, indicator: Bool = false) {
        self.scene = scene
        self.convergent = convergent
        self.indicator = indicator
        fields = [:]
        super.init()
        let labelNode = buildLabelNode()
        addComponent(GeometryComponent(node: labelNode))
    }

    private func buildLabelNode() -> SKSpriteNode {
        let imageName: String = {
            switch (indicator, convergent) {
            case (true, true):
                return "indicatorneg"
            case (true, false):
                return "indicatorpos"
            case (false, true):
                return "touchneg"
            case (false, false):
                return "touchpos"
            }
        }()
        let node = SKSpriteNode(imageNamed: imageName)
        node.position = CGPoint(x: 0.05 * scene.width, y: 0.8 * scene.height)
        node.size = CGSize(width: indicator ? 315 : 180, height: 90)
        node.anchorPoint = CGPoint(x: 0, y: 0.5)
        return node
    }

    private func addIndicator(node: SKNode) {
        let image = UIImage(systemName: "arrowshape.turn.up.left.fill")!
        let indicatorNode = SKSpriteNode(texture: SKTexture(image: image), size: CGSize(width: 90, height: 90))
        indicatorNode.color = .white
        indicatorNode.colorBlendFactor = 1
        node.addChild(indicatorNode)
        indicatorNode.position = CGPoint(x: 120, y: 0)
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
