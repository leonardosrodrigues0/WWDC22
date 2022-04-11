import GameplayKit

class GravityField: GKEntity {

    static private let minimumRadius: Float = 30

    override init() {
        super.init()
        let fieldNode = buildFieldNode()
        let spriteNode = buildSpriteNode()
        fieldNode.addChild(spriteNode)
        addComponent(GeometryComponent(node: fieldNode))
    }

    private func buildFieldNode() -> SKFieldNode {
        let fieldNode = SKFieldNode.radialGravityField()
        fieldNode.strength = -2
        fieldNode.minimumRadius = Self.minimumRadius
        return fieldNode
    }

    private func buildSpriteNode() -> SKNode {
        let node = SKShapeNode(circleOfRadius: CGFloat(Self.minimumRadius))
        node.fillColor = .purple
        node.strokeColor = .clear
        return node
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
