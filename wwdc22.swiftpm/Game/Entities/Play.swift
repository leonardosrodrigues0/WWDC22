import GameplayKit

class Play: GKEntity {

    private weak var scene: GameScene!

    init(scene: GameScene, position: CGPoint) {
        super.init()
        self.scene = scene
        let node = PlayNode(imageNamed: "play")
        node.delegate = self
        node.size = CGSize(width: 180, height: 200)
        node.position = position
        node.isUserInteractionEnabled = true
        addComponent(GeometryComponent(node: node))
    }

    fileprivate func start() {
//        DispatchQueue.main.async {
            self.scene.loadCurrentLevel()
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayNode: SKSpriteNode {
    fileprivate weak var delegate: Play?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.start()
    }
}
