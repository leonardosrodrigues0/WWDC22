import GameplayKit

class Field: GKEntity {

    init(strength: Float = 2, convergent: Bool = false) {
        super.init()
        addComponent(FieldComponent(strength: strength, convergent: convergent))
    }

    func updatePosition(_ pos: CGPoint) {
        component(ofType: FieldComponent.self)?.node.position = pos
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
