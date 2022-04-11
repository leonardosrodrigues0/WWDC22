import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let height: CGFloat = 900
    let width: CGFloat

    private var entities = [GKEntity]()
    private var fieldManager: FieldManager?
    private var lastUpdateTime: TimeInterval = 0

    private let levels: [Level]
    private var levelIndex = 0

    override init() {
        let proportion = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        width = height * (proportion > 1 ? proportion : 1 / proportion)
        levels = Level.buildLevels(width: width, height: height)
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
        self.physicsBody?.categoryBitMask = PhysicsType.notAllowedWall.rawValue
    }

    override func sceneDidLoad() {
        loadCurrentLevel()
    }

    private func loadCurrentLevel() {
        removeAllEntities()
        basicConfig()
        addLevelLabel()
        addEntities(levels[levelIndex].builder())
    }

    private func addLevelLabel() {
        let label = GameLabel("Level \(levelIndex + 1)", position: CGPoint(
            x: 0.1 * width,
            y: 0.9 * height
        ))

        addEntity(label)
    }

    private func basicConfig() {
        self.lastUpdateTime = 0

        let fieldManager = FieldManager(scene: self)
        self.fieldManager = fieldManager
        addEntity(fieldManager)
    }

    override func didMove(to view: SKView) {
        view.isMultipleTouchEnabled = true
    }

    // MARK: - Manage Entities

    func addEntities(_ entities: [GKEntity]) {
        entities.forEach { addEntity($0) }
    }

    func addEntity(_ entity: GKEntity) {
        entities.append(entity)

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            addChild(geometry.node)
        }
    }

    func removeAllEntities() {
        entities.forEach { removeEntity($0) }
    }

    func removeEntities(_ entities: [GKEntity]) {
        entities.forEach { removeEntity($0) }
    }

    func removeEntity(_ entity: GKEntity) {
        entities.removeAll { $0 == entity }

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            geometry.node.removeFromParent()
        }
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
            if levelIndex < levels.count - 1 {
                levelIndex += 1
            } else {
                levelIndex = 0
            }

            loadCurrentLevel()
        } else if contactMask == PhysicsType.deathMask {
            loadCurrentLevel()
        }
    }
}
