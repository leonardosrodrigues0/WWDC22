import GameplayKit

class MenuChargeGenerator: GKEntity {

    private static let interval: TimeInterval = 2
    private static let speed: CGFloat = 1

    weak var scene: GameScene!
    private var lastGenerated: TimeInterval = 0
    private var lastUpdated: TimeInterval = 0
    private let position: CGPoint
    private let radius: CGFloat

    init(scene: GameScene, position: CGPoint) {
        self.scene = scene
        self.position = position
        self.radius = 1.5 * scene.width
        super.init()
        let node = createNode()
        node.position = position
        addComponent(GeometryComponent(node: node))
        generateCharges()
    }

    override func update(deltaTime seconds: TimeInterval) {
        lastUpdated += seconds
        if lastUpdated - lastGenerated > Self.interval {
            generateCharges()
            lastGenerated = lastUpdated
        }
    }

    private func generateCharges() {
        let generatePositions = randomPoints()
        let charge1 = Charge(position: generatePositions.0, type: .charge1)
        let charge2 = Charge(position: generatePositions.1, type: .charge2)
        let speed1 = CGVector(pointA: generatePositions.0, pointB: position).multiply(scalar: Self.speed).sum(vector: CGVector(dx: 40, dy: 40))
        let speed2 = CGVector(pointA: generatePositions.1, pointB: position).multiply(scalar: Self.speed)
        charge1.component(ofType: GeometryComponent.self)!.node.physicsBody?.velocity = speed1
        charge2.component(ofType: GeometryComponent.self)!.node.physicsBody?.velocity = speed2
        scene.addEntity(charge1)
        scene.addEntity(charge2)
    }

    private func createNode() -> SKShapeNode {
        let node = SKShapeNode(circleOfRadius: radius)
        node.fillColor = .clear
        node.strokeColor = .white
        node.physicsBody = SKPhysicsBody(edgeLoopFrom: node.path!)
        node.physicsBody?.categoryBitMask = PhysicsType.menuWall.rawValue
        return node
    }

    private func randomPoints() -> (CGPoint, CGPoint) {
        let angle = Double.random(in: 0 ... 2 * CGFloat.pi)
        let vector = CGVector(
            dx: (radius - 50) * cos(angle),
            dy: (radius - 50) * sin(angle)
        )

        let posVector = CGVector(pointA: .zero, pointB: self.position)

        let position1 = posVector.sum(vector: vector)
        let position2 = posVector.difference(vector: vector)

        return (
            CGPoint(x: position1.dx, y: position1.dy),
            CGPoint(x: position2.dx, y: position2.dy)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
