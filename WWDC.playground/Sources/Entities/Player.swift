import GameplayKit

class Player: GKEntity {

    init(node: SKShapeNode) {
        super.init()
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
        addComponent(ObjectMovementComponent())
        addComponent(MovementControlComponent(
            right: KeyCode.d,
            left: KeyCode.a,
            down: KeyCode.s,
            up: KeyCode.w
        ))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.categoryBitMask = PhysicsType.player.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.floor.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
