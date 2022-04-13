import GameplayKit

class FieldComponent: GKComponent, NodeComponent {

    static private let minimumRadius: Float = 30

    let fieldNode: SKFieldNode

    var node: SKNode {
        fieldNode as SKNode
    }

    init(strength: Float, convergent: Bool = false) {
        fieldNode = Self.buildFieldNode(strength: strength, convergent: convergent)
        super.init()
    }

    static private func buildFieldNode(strength: Float, convergent: Bool) -> SKFieldNode {
        let fieldNode = SKFieldNode.radialGravityField()
        fieldNode.strength = (convergent ? 1 : -1) * strength
        fieldNode.minimumRadius = Self.minimumRadius
        return fieldNode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
