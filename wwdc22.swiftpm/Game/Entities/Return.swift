import GameplayKit

class Return: GKEntity {

    private weak var scene: GameScene!

    init(scene: GameScene, position: CGPoint) {
        super.init()
        self.scene = scene
        let node = ReturnNode(imageNamed: "back")
        node.delegate = self
        node.size = CGSize(width: 180, height: 200)
        node.position = position
        node.isUserInteractionEnabled = true
        addComponent(GeometryComponent(node: node))
    }

    fileprivate func back() {
        self.scene.loadMenuLevel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ReturnNode: SKSpriteNode {
    fileprivate weak var delegate: Return?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.back()
    }
}
