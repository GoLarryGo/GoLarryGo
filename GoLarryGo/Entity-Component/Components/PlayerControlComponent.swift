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
        stateMachine.enter(EnemyWalkState.self)
        //self.stateMachine.enter(CharacterWalkState.self)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        guard stateMachine.currentState?.classForCoder != CharacterDeadState.self else { return }
        stateMachine.enter(CharacterWalkState.self)
    }
    
    func jump() {
        guard stateMachine.currentState?.classForCoder != CharacterDeadState.self else { return }
        stateMachine.enter(CharacterJumpState.self)
    }
    
    func dead() {
        stateMachine.enter(CharacterDeadState.self)
    }


    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        self.entity?.component(ofType: MoveCharacterComponent.self)?.update(deltaTime: seconds)
    }
}
