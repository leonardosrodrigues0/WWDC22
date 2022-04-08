import SpriteKit
import GameplayKit

class GameScene: SKScene {

    static let circleRadius: CGFloat = 30
    static let wallsThickness: CGFloat = 40

    let height: CGFloat = 900
    let width: CGFloat

    private var entities = [GKEntity]()
    private var balls = [UITouch: Player]()
    private var lastUpdateTime: TimeInterval = 0

    override init() {
        width = height * UIScreen.main.bounds.width / UIScreen.main.bounds.height
        super.init(size: CGSize(width: width, height: height))
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsBody?.categoryBitMask = PhysicsType.border.rawValue
        self.physicsWorld.gravity = CGVector.zero
    }

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let platform = buildPlatform()
        addEntity(platform)

        let player = buildPlayer()
        addEntity(player)
    }

    // MARK: - Manage Entities

    private func addEntity(_ entity: GKEntity) {
        entities.append(entity)

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            addChild(geometry.node)
        }
    }

    private func removeEntity(_ entity: GKEntity) {
        entities.removeAll { $0 == entity }

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            geometry.node.removeFromParent()
        }
    }

    // MARK: - Build Entities

    private func buildPlayer() -> Player {
        let player = SKShapeNode(circleOfRadius: Self.circleRadius)
        player.fillColor = .red
        player.position = CGPoint(
            x: width / 4,
            y: height / 2
        )

        return Player(node: player)
    }

    private func buildPlatform() -> GKEntity {
        let platformSize = CGSize(width: width / 4, height: Self.wallsThickness)
        let platform = SKShapeNode(rectOf: platformSize)

        platform.fillColor = .blue
        platform.position = CGPoint(
            x: width / 2,
            y: height / 4
        )

        return StaticObject(node: platform)
    }

    // MARK: - Manage Touches

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let player = buildPlayer()
            player.component(ofType: GeometryComponent.self)?.node.position = touch.location(in: self)
            balls[touch] = player
            addEntity(player)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let player = balls[touch] {
                removeEntity(player)
                balls.removeValue(forKey: touch)
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let player = balls[touch] {
                player.component(ofType: GeometryComponent.self)?.node.position = touch.location(in: self)
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        let deltaTime = currentTime - self.lastUpdateTime
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }

        self.lastUpdateTime = currentTime
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
