import GameplayKit

class Wall: GKEntity {

    var baseThickness: CGFloat { 40 }
    var physicsType: PhysicsType { .notAllowedWall }
    var color: UIColor { .red }

    init(_ pointA: CGPoint, _ pointB: CGPoint) {
        super.init()
        let distanceVector = CGVector(
            dx: pointB.x - pointA.x,
            dy: pointB.y - pointA.y
        )

        let rect = CGRect(origin: .zero, size: CGSize(
            width: distanceVector.magnitude,
            height: baseThickness
        ))

        let roundedRect = rect.extendedAndRoundedPath
        let node = SKShapeNode(path: roundedRect, centered: true)
        node.zRotation = distanceVector.orientation
        node.position = pointA.midPoint(to: pointB)
        commonInit(node)
    }

    init(rect: CGRect) {
        super.init()
        let node = SKShapeNode(rect: rect)
        commonInit(node)
    }

    init(roundedRect: CGRect) {
        super.init()
        let node = SKShapeNode(path: roundedRect.extendedAndRoundedPath)
        commonInit(node)
    }

    private func commonInit(_ node: SKShapeNode) {
        node.fillColor = color
        node.strokeColor = .clear
        addPhysicsBody(node: node)
        addComponent(GeometryComponent(node: node))
    }

    private func addPhysicsBody(node: SKShapeNode) {
        node.physicsBody = SKPhysicsBody(polygonFrom: node.path!)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = physicsType.rawValue
        node.physicsBody?.friction = 0
        node.physicsBody?.restitution = 1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
