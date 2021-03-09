import SpriteKit
import GameplayKit

class RunComponent: GKComponent {
    
    func startRun() -> SKAction {
        let move: SKAction
        var textures: [SKTexture] = []
        move = SKAction.move(by: CGVector(dx: 0, dy: 0), duration: 0.5)
        for i in 1...6 {
            textures.append(SKTexture(imageNamed: "Run_\(i)"))
        }
        let animate = SKAction.animate(with: textures, timePerFrame: 0.1, resize: false, restore: true)
        let repeatAction = SKAction.repeatForever(SKAction.group([move,animate]))
        return repeatAction
    }
    
}
