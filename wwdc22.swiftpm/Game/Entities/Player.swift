import GameplayKit

class Player: GKEntity {

    init(node: SKShapeNode) {
        super.init()
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.categoryBitMask = PhysicsType.player.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.wall.rawValue | PhysicsType.border.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
