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

    private var jumpComponent: JumpComponent {
        return entity!.component(ofType: JumpComponent.self)!
    }

    let keyMap: KeyMap

    public init(keyMap: KeyMap) {
        self.keyMap = keyMap
        super.init()
    }

    // MARK: - Handle Keys

    public func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case keyMap.right:
            handleKeyDown(direction: .right)
        case keyMap.left:
            handleKeyDown(direction: .left)
        case keyMap.up:
            jumpComponent.wannaJump = true
        default:
            return
        }
    }

    private func handleKeyDown(direction: Direction) {
        movementComponent.state = .moving(direction)
    }

    public func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case keyMap.right:
            handleKeyUp(direction: .right)
        case keyMap.left:
            handleKeyUp(direction: .left)
        case keyMap.up:
            jumpComponent.wannaJump = false
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

    // MARK: - Handle Contacts

    private var geometryComponent: GeometryComponent {
        entity!.component(ofType: GeometryComponent.self)!
    }

    private var physicsTypeMask: UInt32 {
        geometryComponent.node.physicsBody!.categoryBitMask
    }

    func didBegin(contact: SKPhysicsContact) {
        if isPlayerFloorContact(contact) {
            jumpComponent.canJump = true
        }
    }

    func didEnd(contact: SKPhysicsContact) {
        if isPlayerFloorContact(contact) {
            jumpComponent.canJump = false
        }
    }

    private func isPlayerFloorContact(_ contact: SKPhysicsContact) -> Bool {
        let playerFloorMask = physicsTypeMask | PhysicsType.floor.rawValue
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == playerFloorMask {
            let isOnTopOfFloor = contact.contactNormal.dy > 0
            return isOnTopOfFloor
        }

        return false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
