//
//  MoveSceneryComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 09/03/21.
//
//
import GameplayKit
import SpriteKit

class MoveSceneryComponent: GKComponent {

//    var spriteNode: SKSpriteNode!
//
//    init(textureName: String) {
//        super.init()
//        self.spriteNode = SKSpriteNode(imageNamed: textureName)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func setAnimation(sizeX: CGFloat) -> SKAction {

        let moveBack = SKAction.moveBy(x: -sizeX, y: 0, duration: 5)
        let repositionBack = SKAction.moveBy(x: sizeX, y: 0, duration: 0)
        let loopBack = SKAction.repeatForever(SKAction.sequence([moveBack,repositionBack]))
        
        return loopBack
//        spriteNode.run(
//            loopBack
//        )
    }
}
