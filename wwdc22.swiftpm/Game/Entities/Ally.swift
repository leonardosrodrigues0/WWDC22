import GameplayKit

class Ally: GKEntity {

    private static let size: CGFloat = 60

    init(position: CGPoint) {
        super.init()
        let node = SKShapeNode(circleOfRadius: Self.size / 2)
        node.fillColor = .white
        node.strokeColor = .clear
        node.position = position
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.categoryBitMask = PhysicsType.ally.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.allowedWall.rawValue | PhysicsType.notAllowedWall.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsType.notAllowedWall.rawValue | PhysicsType.goal.rawValue
        node.physicsBody?.restitution = 1
        node.physicsBody?.linearDamping = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
