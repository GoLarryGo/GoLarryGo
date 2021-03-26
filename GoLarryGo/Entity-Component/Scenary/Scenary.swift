//
//  Scenary.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 15/03/21.
//

import Foundation
import SpriteKit

class Scenery {
    
    func movePlatform(_ size: CGSize) -> SKAction {
        let move = SKAction.moveTo(x: -size.width, duration: 15)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        return sequence
    }
    
    func moveScenery(_ size: CGSize) -> SKAction {
        let moveBack = SKAction.moveBy(x: -size.width, y: 0, duration: 8)
        let repositionBack = SKAction.moveBy(x: size.width, y: 0, duration: 0)
        let loopBack = SKAction.repeatForever(SKAction.sequence([moveBack,repositionBack]))
        return loopBack
    }
    
    func moveSun(_ size: CGSize) -> SKAction {
        let movedown = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 20)
        let loopDown = SKAction.repeatForever(movedown)
        return loopDown
    }
}
