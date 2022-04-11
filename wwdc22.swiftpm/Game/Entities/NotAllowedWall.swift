import GameplayKit

class NotAllowedWall: GKEntity {

    init(rect: CGRect) {
        super.init()
        let node = SKShapeNode(rect: rect)
        node.fillColor = .red
        node.strokeColor = .clear
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsType.notAllowedWall.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsType.ally.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
