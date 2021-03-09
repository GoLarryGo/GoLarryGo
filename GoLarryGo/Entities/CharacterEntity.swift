import SpriteKit
import GameplayKit

// Cria a entidade Character main, herdando de GKEntity
class CharacterEntity: GKEntity {
    
    override init() {
        super.init()
        
        // Utiliza o componente VisualComponent para gerar o sprite da entidade
        let visualComponent = VisualComponent(texture: SKTexture(imageNamed: "Dude"), name: "character")
        addComponent(visualComponent)
        visualComponent.node.physicsBody = SKPhysicsBody(circleOfRadius: visualComponent.node.size.height/2)
        visualComponent.node.physicsBody?.isDynamic = true
        visualComponent.node.physicsBody?.allowsRotation = false
        let runComponent = RunComponent()
        addComponent(runComponent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

