//
//  MoveScenery.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 10/03/21.
//

import Foundation
import SpriteKit
import GameplayKit

//class WalkLeftState: WalkState {
//    override var direction: PanDirection {
//        .left
//    }
//}
//
//class WalkRightState: WalkState {
//    override var direction: PanDirection {
//        .right
//    }
//}

class MoveSceneryState: GKState {
    var entity: GKEntity
    
    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }

//    var moveComponent: MoveSceneryComponent? {
//        self.entity.component(ofType: MoveSceneryComponent.self)
//    }

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("back")

        animatedSpriteComponent?.setAnimation(atlasName: "back")
        //walkComponent?.walk(direction: direction)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
