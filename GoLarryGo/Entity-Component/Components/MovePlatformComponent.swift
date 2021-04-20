//
//  MovePlatformComponent.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 05/04/21.
//

import UIKit
import GameplayKit

class MovePlatformComponent: GKComponent {
    var velocity: CGFloat
    
    var tileRowComponent: TileRowComponent {
        (self.entity?.component(ofType: TileRowComponent.self))!
    }
    
    init(velocity: CGFloat = 8) {
        self.velocity = velocity
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopMove() {
        tileRowComponent.tileNodes.forEach { node in
            node.removeAllActions()
        }
    }
    
    func startMove() {
        tileRowComponent.tileNodes.forEach { node in
            let move = SKAction.moveBy(x: -velocity, y: 0, duration: 0.1)
            node.run(SKAction.repeatForever(move))
        }
    }
}
