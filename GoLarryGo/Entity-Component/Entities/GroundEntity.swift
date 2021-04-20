//
//  BackgroundEntity.swift
//  GoLarryGo
//
//  Created by aluno on 09/03/21.
//

import Foundation
import GameplayKit

class GroundEntity: GKEntity {

    override init() {
        super.init()
        self.addComponent(AnimatedSpriteComponent(textureName: "ground"))
        self.addComponent(MoveGroundComponent(velocity: 10))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
