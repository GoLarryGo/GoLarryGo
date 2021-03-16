//
//  BackgroundEntity.swift
//  GoLarryGo
//
//  Created by aluno on 09/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class FloorEntity: GKEntity {
    override init() {
        super.init()
        // Utiliza o componente VisualComponent para gerar o sprite da entidade
        let visualComponent = AnimatedSpriteComponent(textureName: "back03")
        addComponent(visualComponent)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
