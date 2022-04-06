import SpriteKit
import GameplayKit
import AppKit

public class GameScene: SKScene {

    static let size = CGSize(width: 1800, height: 900)
    static let circleRadius: CGFloat = 20
    static let netHeight: CGFloat = 300
    static let floorHeight: CGFloat = 40
    static let velocityFactor: CGFloat = 3

    private var lastUpdateTime: TimeInterval = 0
    private var circleNode: SKShapeNode?

    public override init() {
        super.init(size: Self.size)
    }

    public override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let circle = buildCircle()
        self.circleNode = circle
        addChild(circle)

        let floor = buildFloor()
        addChild(floor)

        let net = buildNet()
        addChild(net)

        let leftWall = buildWall(x: -1)
        addChild(leftWall)

        let rightWall = buildWall(x: Self.size.width + 1)
        addChild(rightWall)
    }

    private func buildCircle() -> SKShapeNode {
        let player = Player()
        return player.node
    }

    private func buildFloor() -> SKShapeNode {
        let floorSize = CGSize(width: Self.size.width, height: Self.floorHeight)
        let floor = SKShapeNode(rectOf: floorSize)

        floor.fillColor = .blue
        floor.position = CGPoint(
            x: Self.size.width / 2,
            y: floorSize.height / 2
        )

        floor.physicsBody = SKPhysicsBody(rectangleOf: floorSize)
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = PhysicsType.floor.rawValue
        return floor
    }

    private func buildNet() -> SKShapeNode {
        let netSize = CGSize(width: Self.circleRadius / 2, height: Self.netHeight)
        let net = SKShapeNode(rectOf: netSize)

        net.fillColor = .green
        net.position = CGPoint(
            x: Self.size.width / 2,
            y: Self.floorHeight + Self.netHeight / 2
        )

        net.physicsBody = SKPhysicsBody(rectangleOf: netSize)
        net.physicsBody?.isDynamic = false
        net.physicsBody?.categoryBitMask = PhysicsType.floor.rawValue
        return net
    }

    private func buildWall(x: CGFloat) -> SKShapeNode {
        let wallSize = CGSize(width: 1, height: 20 * Self.size.height)
        let wall = SKShapeNode(rectOf: wallSize)

        wall.position = CGPoint(x: x, y: Self.size.height / 2)
        wall.physicsBody = SKPhysicsBody(rectangleOf: wallSize)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.categoryBitMask = PhysicsType.floor.rawValue
        return wall
    }

    public override func keyDown(with event: NSEvent) {
        if event.keyCode == KeyCode.w {
            print("DOWN")
        }
    }

    public override func keyUp(with event: NSEvent) {
        if event.keyCode == KeyCode.w {
            print("UP")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
