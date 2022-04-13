import GameplayKit

class Goal: GKEntity {

    private static let size: CGFloat = 60
    
    init(position: CGPoint) {
        super.init()
        let node = SKSpriteNode(imageNamed: "goal")
        node.position = position
        node.size = CGSize(width: Self.size, height: Self.size)
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(texture: node.texture!, size: CGSize(width: Self.size, height: Self.size))
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsType.goal.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
