//
//  PlayerControlComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 10/03/21.
//

import Foundation
import GameplayKit

class PlayerControlComponent: GKComponent {

    var stateMachine: GKStateMachine

    init(states: [GKState]) {
        self.stateMachine = GKStateMachine(states: states)
        self.stateMachine.enter(MoveSceneryState.self)
        self.stateMachine.enter(CharacterWalkState.self)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func halt() {
        stateMachine.enter(MoveSceneryState.self)
        stateMachine.enter(CharacterWalkState.self)
    }
    
    func jump() {
        stateMachine.enter(CharacterJumpState.self)
    }


    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        self.entity?.component(ofType: MoveCharacterComponent.self)?.update(deltaTime: seconds)
    }
}
