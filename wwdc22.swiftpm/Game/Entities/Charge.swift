import GameplayKit

class Charge: GKEntity {

    private static let size: CGFloat = 60

    private let type: PhysicsType

    init(position: CGPoint, convergent: Bool = false, type: PhysicsType = .charge1) {
        self.type = type
        super.init()
        let spriteNode = createSpriteNode(position: position)
        addComponent(GeometryComponent(node: spriteNode))
        let fieldNode = createFieldNode(convergent: convergent)
        spriteNode.addChild(fieldNode)
    }

    private func createFieldNode(convergent: Bool) -> SKFieldNode {
        let fieldComponent = FieldComponent(strength: 2, convergent: convergent)
        let fieldNode = fieldComponent.fieldNode
        fieldNode.categoryBitMask = type.rawValue
        return fieldNode
    }

    private func createSpriteNode(position: CGPoint) -> SKNode {
        let node = SKShapeNode(circleOfRadius: Self.size / 2)
        node.fillColor = .white
        node.strokeColor = .clear
        node.position = position
        addPhysicsBody(node: node)
        return node
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
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
