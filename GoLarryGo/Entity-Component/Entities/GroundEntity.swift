//
//  BackgroundEntity.swift
//  GoLarryGo
//
//  Created by aluno on 09/03/21.
//

import Foundation
import GameplayKit

class Ground: GKEntity {

    init(numberOfTiles: Int, assetName: String = "ground") {
        super.init()
        addComponent(TileRowComponent(numberOfTiles: numberOfTiles, assetName: assetName))
        addComponent(PlayerControlComponent(states: []))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
