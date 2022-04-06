import GameplayKit

public class GeometryComponent: GKComponent {

    public let node: SKNode

    public init(node: SKNode) {
        self.node = node
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
