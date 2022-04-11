import GameplayKit

class AllowedWall: GKEntity {

    init(rect: CGRect) {
        super.init()
        let node = SKShapeNode(rect: rect)
        node.fillColor = .blue
        node.strokeColor = .clear
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsType.allowedWall.rawValue
        node.physicsBody?.restitution = 1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
