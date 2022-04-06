import GameplayKit

public enum MovementState {
    case stopped
    case moving(Direction)
    case free
}

public class ObjectMovementComponent: GKComponent {

    private let horizontalSpeedFactor: CGFloat

    private var node: SKNode {
        entity!.component(ofType: GeometryComponent.self)!.node
    }

    private var physicsBody: SKPhysicsBody {
        node.physicsBody!
    }

    var state: MovementState = .stopped

    public override init() {
        horizontalSpeedFactor = 1000
        super.init()
    }

    public init(horizontalSpeedFactor: CGFloat) {
        self.horizontalSpeedFactor = horizontalSpeedFactor
        super.init()
    }

    public override func update(deltaTime seconds: TimeInterval) {
        switch state {
        case .stopped:
            stop()
        case .moving(let direction):
            move(direction: direction)
        case .free:
            return
        }
    }

    private func stop() {
        physicsBody.velocity.dx = 0
        physicsBody.angularVelocity = 0
    }

    private func move(direction: Direction) {
        physicsBody.velocity.dx = horizontalSpeedFactor * CGFloat(direction.value)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
