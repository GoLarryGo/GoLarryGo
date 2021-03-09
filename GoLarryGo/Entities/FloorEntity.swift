//
//  BackgroundEntity.swift
//  GoLarryGo
//
//  Created by aluno on 09/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class BackgroundEntity: GKEntity {
    var name: String?
    override init() {
        super.init()
        
        guard let name = self.name else {
            fatalError()
        }
        
        // Utiliza o componente VisualComponent para gerar o sprite da entidade
        let visualComponent = VisualComponent(texture: SKTexture(imageNamed: name), name: name)
        addComponent(visualComponent)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
