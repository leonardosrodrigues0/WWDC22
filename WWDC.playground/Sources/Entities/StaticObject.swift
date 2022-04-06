import GameplayKit

class StaticObject: GKEntity {

    init(node: SKShapeNode, category: PhysicsType) {
        super.init()
        addPhysicsBody(node: node, category: category)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode, category: PhysicsType) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = category.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
