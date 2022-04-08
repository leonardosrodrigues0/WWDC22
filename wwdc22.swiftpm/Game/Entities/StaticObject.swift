import GameplayKit

class StaticObject: GKEntity {

    init(node: SKShapeNode) {
        super.init()
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsType.wall.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
