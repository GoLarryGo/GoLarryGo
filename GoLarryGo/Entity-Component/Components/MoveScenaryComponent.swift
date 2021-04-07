//
//  MoveScenaryComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 06/04/21.
//

import UIKit
import GameplayKit

class MoveScenaryComponent: GKComponent {
    var velocity: CGFloat
    var move: Bool = false
    
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
    
    func startMove() {
        move = true
    }
    
    func stopMove() {
        move = false
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if move {
            tileRowComponent.tileNodes.forEach { node in
                node.position.x -= velocity
            }
        }
        
    }
}
