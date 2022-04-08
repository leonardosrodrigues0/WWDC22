import GameplayKit

class Player: GKEntity {

    init(node: SKShapeNode, physicsType: PhysicsType, keyMap: KeyMap) {
        super.init()
        addPhysicsBody(node: node, physicsType: physicsType)
        addComponent(GeometryComponent(node: node))
        addComponent(ObjectMovementComponent())
        addComponent(JumpComponent())
        addComponent(MovementControlComponent(keyMap: keyMap))
    }

    private func addPhysicsBody(node: SKShapeNode, physicsType: PhysicsType) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.categoryBitMask = physicsType.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.floor.rawValue | PhysicsType.player1.rawValue | PhysicsType.player2.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsType.floor.rawValue
        node.physicsBody?.restitution = 0
        node.physicsBody?.mass = 100
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
