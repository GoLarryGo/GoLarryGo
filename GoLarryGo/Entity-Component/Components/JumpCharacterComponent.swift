//
//  JumpCharacterComponent.swift
//  GoLarryGo
//
//  Created by aluno on 12/03/21.
//
import GameplayKit
import UIKit

class JumpCharacterComponent: GKComponent {
    let impulse: CGFloat

    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)
    }

    init(impulse: CGFloat) {
        self.impulse = impulse
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func jump(completion: @escaping () -> Void = { }) {
        
        let sequence = SKAction.sequence([
            SKAction.move(by: CGVector(dx: 0, dy: impulse), duration: 0.4),
            SKAction.move(by: CGVector(dx: 0, dy: -impulse), duration: 0.4)
        ])
        print(impulse)
        sequence.duration = 0.8
        sequence.timingMode = .easeIn
        
        //animatedSpriteComponent?.setAnimationSingle(atlasName: "larryJump")
        //animatedSpriteComponent?.spriteNode.physicsBody?.applyImpulse(CGVector(dx: 2, dy: 20))
        animatedSpriteComponent?.spriteNode.run(sequence, completion: completion)
    }
}
