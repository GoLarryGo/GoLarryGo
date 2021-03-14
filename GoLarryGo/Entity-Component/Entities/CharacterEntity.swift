import SpriteKit
import GameplayKit

// Cria a entidade Character main, herdando de GKEntity
class CharacterEntity: GKEntity {
    
    override init() {
        super.init()
        // Utiliza o componente AnimatedSpriteComponent para gerar o sprite da entidade
        let animetedSpriteComponent = AnimatedSpriteComponent(atlasName: "larryWalk")
        addComponent(animetedSpriteComponent)
        setupPhysicsBody(component: animetedSpriteComponent)
        
        addComponent(
            PlayerControlComponent(states: [
                CharacterWalkState(self),
                CharacterJumpState(self)
            ])
        )
        
        addComponent(MoveCharacterComponent())
        addComponent(JumpCharacterComponent(impulse: 300))
    }
    
    func setupPhysicsBody(component: AnimatedSpriteComponent) {
        component.spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: component.spriteNode.size.height/2)
        component.spriteNode.physicsBody?.isDynamic = true
        component.spriteNode.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

