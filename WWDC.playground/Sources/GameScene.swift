import SpriteKit
import GameplayKit
import AppKit

public class GameScene: SKScene {

    static let size = CGSize(width: 1800, height: 900)
    static let circleRadius: CGFloat = 30
    static let netHeight: CGFloat = 300
    static let floorHeight: CGFloat = 40

    var entities = [GKEntity]()
    private var lastUpdateTime: TimeInterval = 0

    public override init() {
        super.init(size: Self.size)
        physicsWorld.contactDelegate = self
    }

    public override func sceneDidLoad() {
        self.lastUpdateTime = 0

        let player1 = buildPlayer1()
        addEntity(player1)

        let player2 = buildPlayer2()
        addEntity(player2)

        let floor = buildFloor()
        addEntity(floor)

        let platform = buildPlatform()
        addEntity(platform)

        let leftWall = buildWall(x: -1)
        addEntity(leftWall)

        let rightWall = buildWall(x: Self.size.width + 1)
        addEntity(rightWall)
    }

    private func addEntity(_ entity: GKEntity) {
        entities.append(entity)

        if let geometry = entity.component(ofType: GeometryComponent.self) {
            addChild(geometry.node)
        }
    }

    private func buildPlayer1() -> Player {
        let player = SKShapeNode(rectOf: CGSize(width: Self.circleRadius, height: Self.circleRadius))
//        let player = SKShapeNode(circleOfRadius: Self.circleRadius)
        player.fillColor = .purple
        player.position = CGPoint(
            x: Self.size.width / 4,
            y: Self.size.height / 2
        )

        let keyMap = KeyMap(
            right: KeyCode.d,
            left: KeyCode.a,
            up: KeyCode.w,
            down: KeyCode.s
        )

        return Player(node: player, physicsType: .player1, keyMap: keyMap)
    }

    private func buildPlayer2() -> Player {
        let player = SKShapeNode(circleOfRadius: Self.circleRadius)
        player.fillColor = .orange
        player.position = CGPoint(
            x: 3 * Self.size.width / 4,
            y: Self.size.height / 2
        )

        let keyMap = KeyMap(
            right: KeyCode.l,
            left: KeyCode.j,
            up: KeyCode.i,
            down: KeyCode.k
        )

        return Player(node: player, physicsType: .player2, keyMap: keyMap)
    }

    private func buildFloor() -> GKEntity {
        let floorSize = CGSize(width: Self.size.width, height: Self.floorHeight)
        let floor = SKShapeNode(rectOf: floorSize)

        floor.fillColor = .blue
        floor.position = CGPoint(
            x: Self.size.width / 2,
            y: floorSize.height / 2
        )

        return StaticObject(node: floor, category: .floor)
    }

    private func buildPlatform() -> GKEntity {
        let platformSize = CGSize(width: Self.size.width / 4, height: Self.floorHeight)
        let platform = SKShapeNode(rectOf: platformSize)

        platform.fillColor = .blue
        platform.position = CGPoint(
            x: Self.size.width / 2,
            y: Self.size.height / 4
        )

        return StaticObject(node: platform, category: .floor)
    }

    private func buildNet() -> GKEntity {
        let netSize = CGSize(width: Self.circleRadius / 2, height: Self.netHeight)
        let net = SKShapeNode(rectOf: netSize)

        net.fillColor = .green
        net.position = CGPoint(
            x: Self.size.width / 2,
            y: Self.floorHeight + Self.netHeight / 2
        )

        return StaticObject(node: net, category: .floor)
    }

    private func buildWall(x: CGFloat) -> GKEntity {
        let wallSize = CGSize(width: 20, height: 20 * Self.size.height)
        let wall = SKShapeNode(rectOf: wallSize)

        wall.position = CGPoint(x: x, y: Self.size.height / 2)

        return StaticObject(node: wall, category: .floor)
    }

    private var playersMovementControl: [MovementControlComponent] {
        let players = entities.compactMap { $0 as? Player }
        return players.map { $0.component(ofType: MovementControlComponent.self)! }
    }

    public override func keyDown(with event: NSEvent) {
        playersMovementControl.forEach { $0.keyDown(with: event) }
    }

    public override func keyUp(with event: NSEvent) {
        playersMovementControl.forEach { $0.keyUp(with: event) }
    }

    public override func update(_ currentTime: TimeInterval) {
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
    public func didBegin(_ contact: SKPhysicsContact) {
        playersMovementControl.forEach { $0.didBegin(contact: contact) }
    }

    public func didEnd(_ contact: SKPhysicsContact) {
        playersMovementControl.forEach { $0.didEnd(contact: contact) }
    }
}
