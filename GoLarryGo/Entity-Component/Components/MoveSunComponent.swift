//
//  MoveSunComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 09/03/21.
//

import GameplayKit
import SpriteKit



class MoveSunComponent: GKComponent {
    func setAnimation(_ position: CGPoint) -> SKAction {
        let moveDown = SKAction.moveBy(x: -position.x/2, y: -position.y/2, duration: 6)
        let down = SKAction.repeatForever(moveDown)
        return down
    }
}


//CGPoint(x: size.width/2, y: size.height/1.3)
