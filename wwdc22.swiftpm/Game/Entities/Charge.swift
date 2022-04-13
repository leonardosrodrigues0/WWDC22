import GameplayKit

class Charge: GKEntity {

    private static let size: CGFloat = 60

    private let convergent: Bool
    private let type: PhysicsType

    init(position: CGPoint, convergent: Bool = false, type: PhysicsType = .charge1) {
        self.convergent = convergent
        self.type = type
        super.init()
        let spriteNode = createSpriteNode(position: position)
        addComponent(GeometryComponent(node: spriteNode))
        let fieldNode = createFieldNode()
        spriteNode.addChild(fieldNode)
    }

    private func createFieldNode() -> SKFieldNode {
        let fieldComponent = FieldComponent(strength: 2, convergent: convergent)
        let fieldNode = fieldComponent.fieldNode
        fieldNode.categoryBitMask = type.rawValue
        return fieldNode
    }

    private func createSpriteNode(position: CGPoint) -> SKNode {
        let node = SKSpriteNode(imageNamed: convergent ? "negative" : "positive")
        node.size = CGSize(width: Self.size, height: Self.size)
        node.position = position
        addPhysicsBody(node: node)
        return node
    }

    private func addPhysicsBody(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(texture: node.texture!, size: CGSize(width: Self.size, height: Self.size))
        node.physicsBody?.categoryBitMask = self.type.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.bitMask(for: [
            .allowedWall,
            .notAllowedWall
        ]) | PhysicsType.chargesMask

        node.physicsBody?.contactTestBitMask = PhysicsType.notAllowedWall.rawValue | PhysicsType.goal.rawValue
        node.physicsBody?.restitution = 1
        node.physicsBody?.linearDamping = 0
        node.physicsBody?.fieldBitMask = PhysicsType.chargesMask & (~type.rawValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
