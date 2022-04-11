import GameplayKit

class GameLabel: GKEntity {

    init(_ text: String, position: CGPoint) {
        super.init()
        let node = SKLabelNode(text: text)
        node.fontSize = 60
        node.fontColor = .white
        node.position = position
        addComponent(GeometryComponent(node: node))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
