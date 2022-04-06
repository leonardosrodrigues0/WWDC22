import GameplayKit

public struct KeyMap {
    let right: UInt16
    let left: UInt16
    let up: UInt16
    let down: UInt16
}

public class MovementControlComponent: GKComponent {

    private var movementComponent: ObjectMovementComponent {
        return entity!.component(ofType: ObjectMovementComponent.self)!
    }

    let keyMap: KeyMap

    public init(keyMap: KeyMap) {
        self.keyMap = keyMap
        super.init()
    }

    public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case keyMap.right:
            movementComponent.state = .moving(.right)
        case keyMap.left:
            movementComponent.state = .moving(.left)
        default:
            return
        }
    }

    public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case keyMap.right:
            handleKeyUp(direction: .right)
        case keyMap.left:
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
