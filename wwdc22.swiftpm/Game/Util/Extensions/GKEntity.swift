import GameplayKit

protocol NodeComponent: GKComponent {
    var node: SKNode { get }
}

extension GKEntity {

    func applyOnNodes(_ body: (SKNode) -> Void) {
        components.compactMap { component in
            component as? NodeComponent
        }.forEach { nodeComponent in
            body(nodeComponent.node)
        }
    }
}
