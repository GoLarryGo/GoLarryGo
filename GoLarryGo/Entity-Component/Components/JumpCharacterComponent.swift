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
        let jumpAction = SKAction.run {
            self.animatedSpriteComponent?.spriteNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 9))
        }
        let sequence = SKAction.sequence([jumpAction])
        sequence.duration = 0.8
        sequence.timingMode = .easeIn
        animatedSpriteComponent?.spriteNode.run(sequence, completion: completion)
    }
}
