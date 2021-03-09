//
//  CloudsEntity.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 09/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class CloudsEntity: GKEntity {
    override init() {
        super.init()
        // Utiliza o componente VisualComponent para gerar o sprite da entidade
        let visualComponent = VisualComponent(texture: SKTexture(imageNamed: "clouds"), name: "clouds")
        addComponent(visualComponent)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
