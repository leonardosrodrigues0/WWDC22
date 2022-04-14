import GameplayKit

enum TextStyle {
    case levelLabel
    case title

    var name: String {
        switch self {
        case .levelLabel:
            return "AvenirNext-Regular"
        case .title:
            return "AvenirNext-Bold"
        }
    }
}

class GameLabel: GKEntity {

    init(_ text: String, position: CGPoint, type: TextStyle = .title) {
        super.init()
        let node = SKLabelNode(text: text)
        node.fontSize = 60
        node.fontColor = .white
        node.fontName = type.name
        node.position = position
        addComponent(GeometryComponent(node: node))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
