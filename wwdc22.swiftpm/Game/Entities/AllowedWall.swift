import GameplayKit

class AllowedWall: Wall {

    override var color: UIColor { .blue }
    override var physicsType: PhysicsType { .allowedWall }

}
