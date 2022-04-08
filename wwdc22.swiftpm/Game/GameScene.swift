import SpriteKit
import GameplayKit

class GameScene: SKScene {

    static let wallsThickness: CGFloat = 40

    let height: CGFloat = 900
    let width: CGFloat

    private var entities = [GKEntity]()
    private var fieldManager: FieldManager?
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

    override func didMove(to view: SKView) {
        view.isMultipleTouchEnabled = true
    }

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let platform = buildPlatform()
        addEntity(platform)

        let ally = buildAlly()
        addEntity(ally)

        let fieldManager = FieldManager(scene: self)
        self.fieldManager = fieldManager
        addEntity(fieldManager)
    }

    // MARK: - Manage Entities

    func addEntity(_ entity: GKEntity) {
        entities.append(entity)

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            addChild(geometry.node)
        }
    }

    func removeEntity(_ entity: GKEntity) {
        entities.removeAll { $0 == entity }

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            geometry.node.removeFromParent()
        }
    }

    // MARK: - Build Entities

    private func buildAlly() -> Ally {
        return Ally(position: CGPoint(
            x: width / 4,
            y: height / 2
        ))
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
        fieldManager?.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fieldManager?.touchesEnded(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        fieldManager?.touchesMoved(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        fieldManager?.touchesEnded(touches, with: event)
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
