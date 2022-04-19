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

    init(_ text: String, position: CGPoint, scene: GameScene, type: TextStyle = .title, size: CGFloat = 60, limitedSpace: Bool = true) {
        super.init()
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont(name: type.name, size: size * scene.width / 1500)!], range: range)
        let node = SKLabelNode(attributedText: attrString)
        node.position = position
        node.numberOfLines = 0
        node.verticalAlignmentMode = .top
        if limitedSpace {
            node.preferredMaxLayoutWidth = 0.5 * scene.width
        }
        addComponent(GeometryComponent(node: node))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
