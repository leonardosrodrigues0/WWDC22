import SpriteKit

class Player {

    let node: SKShapeNode

    init() {
        node = SKShapeNode(circleOfRadius: GameScene.circleRadius)
        node.fillColor = .red
        node.position = CGPoint(
            x: GameScene.size.width / 4,
            y: GameScene.size.height / 2
        )

        node.physicsBody = SKPhysicsBody(circleOfRadius: GameScene.circleRadius)
        node.physicsBody?.categoryBitMask = PhysicsType.player.rawValue
        node.physicsBody?.collisionBitMask = PhysicsType.floor.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
