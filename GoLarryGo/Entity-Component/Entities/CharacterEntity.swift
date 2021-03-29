import SpriteKit
import GameplayKit

// Cria a entidade Character main, herdando de GKEntity
class CharacterEntity: GKEntity {
    
    override init() {
        super.init()
        // Utiliza o componente AnimatedSpriteComponent para gerar o sprite da entidade
        let animetedSpriteComponent = AnimatedSpriteComponent(atlasName: "larryWalk")
        animetedSpriteComponent.spriteNode.size = CGSize(width: 64, height: 64)
        addComponent(animetedSpriteComponent)
        setupPhysicsBody(component: animetedSpriteComponent)
        
        addComponent(
            PlayerControlComponent(states: [
                CharacterWalkState(self),
                CharacterJumpState(self),
                CharacterDeadState(self)
            ])
        )
        
        addComponent(MoveCharacterComponent())
        addComponent(JumpCharacterComponent(impulse: 192))
    }
    
    func setupPhysicsBody(component: AnimatedSpriteComponent) {
    
        let sizeComponent = CGSize(width: component.spriteNode.size.width/2 , height: component.spriteNode.size.height + 6)
        
        component.spriteNode.physicsBody = SKPhysicsBody(texture: component.spriteNode.texture!, size: sizeComponent)

        component.spriteNode.physicsBody?.isDynamic = true
        component.spriteNode.physicsBody?.allowsRotation = false
        component.spriteNode.physicsBody?.affectedByGravity = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

