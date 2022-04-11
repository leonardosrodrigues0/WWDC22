import GameplayKit

class Goal: GKEntity {

    private static let size: CGFloat = 60
    
    init(position: CGPoint) {
        super.init()
        let node = SKShapeNode(circleOfRadius: Self.size / 2)
        node.fillColor = .green
        node.strokeColor = .clear
        node.position = position
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsType.goal.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsType.ally.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
