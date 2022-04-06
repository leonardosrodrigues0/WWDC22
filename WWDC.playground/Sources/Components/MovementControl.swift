import GameplayKit

public class MovementControlComponent: GKComponent {

    private var movementComponent: ObjectMovementComponent {
        return entity!.component(ofType: ObjectMovementComponent.self)!
    }

    private let rightCode: UInt16
    private let leftCode: UInt16
    private let downCode: UInt16
    private let upCode: UInt16

    public init(right: UInt16, left: UInt16, down: UInt16, up: UInt16) {
        self.rightCode = right
        self.leftCode = left
        self.downCode = down
        self.upCode = up
        super.init()
    }

    public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case rightCode:
            movementComponent.state = .moving(.right)
        case leftCode:
            movementComponent.state = .moving(.left)
        default:
            return
        }
    }

    public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case rightCode:
            handleKeyUp(direction: .right)
        case leftCode:
            handleKeyUp(direction: .left)
        default:
            return
        }
    }

    private func handleKeyUp(direction handleDirection: Direction) {
        switch movementComponent.state {
        case .moving(let direction):
            if direction == handleDirection {
                movementComponent.state = .stopped
            }
        default:
            return
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
