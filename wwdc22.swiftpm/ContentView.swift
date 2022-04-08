import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene: GameScene = {
        let scene = GameScene()
        scene.scaleMode = .aspectFit
        return scene
    }()

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
