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

    init(_ text: String, position: CGPoint, type: TextStyle = .title, size: CGFloat = 60) {
        super.init()
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont(name: type.name, size: size)!], range: range)
        let node = SKLabelNode(attributedText: attrString)
        node.position = position
        node.numberOfLines = 0
        node.preferredMaxLayoutWidth = 0.85 * UIScreen.main.bounds.width
        node.verticalAlignmentMode = .top
        addComponent(GeometryComponent(node: node))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
