import GameplayKit

class JumpComponent: GKComponent {

    private static let jumpImpulse: CGFloat = 50

    private var node: SKNode {
        entity!.component(ofType: GeometryComponent.self)!.node
    }

    private var physicsBody: SKPhysicsBody {
        node.physicsBody!
    }

    var wannaJump = false
    var canJump = false

    override func update(deltaTime seconds: TimeInterval) {
        if wannaJump && canJump {
            jump()
        }
    }

    private func jump() {
        print("JUMP")
        physicsBody.velocity.dy = 0
        physicsBody.applyImpulse(CGVector(dx: 0, dy: Self.jumpImpulse))
        canJump = false
    }
}
