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
        let proportion = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        width = height * (proportion > 1 ? proportion : 1 / proportion)
        super.init(size: CGSize(width: width, height: height))
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        addBorder()
    }

    private func addBorder() {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsBody?.categoryBitMask = PhysicsType.allowedWall.rawValue
    }

    override func didMove(to view: SKView) {
        view.isMultipleTouchEnabled = true
    }

    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let ally = buildAlly()
        addEntity(ally)

        let goal = buildGoal()
        addEntity(goal)

        let platform = buildPlatform()
        addEntity(platform)

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

    private func buildGoal() -> Goal {
        return Goal(position: CGPoint(
            x: 3 * width / 4,
            y: height / 2
        ))
    }

    private func buildPlatform() -> NotAllowedWall {
        return NotAllowedWall(rect: CGRect(
            center: CGPoint(
                x: width / 2,
                y: height / 4
            ),
            size: CGSize(
                width: width / 4,
                height: Self.wallsThickness
            )
        ))
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        if contactMask == PhysicsType.finishMask {
            print("Nice!")
            self.backgroundColor = .darkGray
        } else if contactMask == PhysicsType.deathMask {
            print("Bad!")
            self.backgroundColor = .black
        }
    }
}
