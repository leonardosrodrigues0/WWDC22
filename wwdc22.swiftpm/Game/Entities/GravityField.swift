import GameplayKit


//    private func buildField() -> GKEntity {
//        let gravityField = SKFieldNode.radialGravityField()
//        gravityField.falloff = 0.5;
//        gravityField.strength = 1;
//        gravityField.animationSpeed = 0.5;
//        gravityField.position = CGPoint(
//            x: 3 * width / 4,
//            y: height / 2
//        )
//
//        return StaticObject(node: gravityField)
//    }

class GravityField: GKEntity {

    override init() {
        super.init()
        let fieldNode = SKFieldNode.radialGravityField()
        fieldNode.falloff = 0.5;
        fieldNode.strength = 1;
        fieldNode.animationSpeed = 0.5;
        addComponent(GeometryComponent(node: fieldNode))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
