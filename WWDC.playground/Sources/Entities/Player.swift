import GameplayKit

class Player: GKEntity {

    init(node: SKShapeNode, keyMap: KeyMap) {
        super.init()
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
        addComponent(ObjectMovementComponent())
        addComponent(MovementControlComponent(keyMap: keyMap))
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
