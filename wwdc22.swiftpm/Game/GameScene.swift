import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let height: CGFloat = 900
    let width: CGFloat

    private var entities = [GKEntity]()
    private var lastUpdateTime: TimeInterval = 0

    private lazy var levels: [Level] = {
        Level.buildLevels(scene: self)
    }()

    private var levelIndex = 0

    override init() {
        let proportion = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        width = height * (proportion > 1 ? proportion : 1 / proportion)
        super.init(size: CGSize(width: width, height: height))
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        addBorder()
        self.backgroundColor = UIColor(white: 0.1, alpha: 1)
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
        lastUpdateTime = 0
        addLevelLabel()
        addEntities(levels[levelIndex].build())
    }

    private func addLevelLabel() {
        let label = GameLabel("Level \(levelIndex + 1)", position: CGPoint(
            x: 0.1 * width,
            y: 0.9 * height
        ), type: .levelLabel)

        addEntity(label)
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
        entity.applyOnNodes(self.addChild(_:))
    }

    func removeAllEntities() {
        removeEntities(self.entities)
    }

    func removeEntities(_ entities: [GKEntity]) {
        entities.forEach { removeEntity($0) }
    }

    func removeEntity(_ entity: GKEntity) {
        entities.removeAll { $0 == entity }
        entity.applyOnNodes { $0.removeFromParent() }
    }

    // MARK: - Manage Touches

    private var fieldManager: FieldManager? {
        entities.compactMap { entity in
            entity as? FieldManager
        }.first
    }

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
        guard contactMask & PhysicsType.chargesMask != 0 else {
            return
        }

        if contactMask & PhysicsType.goal.rawValue != 0 {
            chargeGoalContact(contact)
        } else if contactMask & PhysicsType.notAllowedWall.rawValue != 0 {
            loadCurrentLevel()
        }
    }

    private func chargeGoalContact(_ contact: SKPhysicsContact) {
        let charges = entities.compactMap { $0 as? Charge }
        if charges.count < 2 {
            goToNextLevel()
            loadCurrentLevel()
        } else {
            let chargeNode: SKNode = {
                if contact.bodyA.categoryBitMask == PhysicsType.goal.rawValue {
                    return contact.bodyB.node!
                } else {
                    return contact.bodyA.node!
                }
            }()

            let charge = charges.first { charge in
                charge.component(ofType: GeometryComponent.self)!.node == chargeNode
            }!

            removeEntity(charge)
        }
    }

    private func goToNextLevel() {
        if levelIndex < levels.count - 1 {
            levelIndex += 1
        } else {
            levelIndex = 0
        }
    }
}
