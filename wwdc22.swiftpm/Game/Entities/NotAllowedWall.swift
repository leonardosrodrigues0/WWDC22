import GameplayKit

class NotAllowedWall: Wall {

    override var color: UIColor { .red }
    override var physicsType: PhysicsType { .notAllowedWall }

}
