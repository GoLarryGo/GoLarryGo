//
//  BackgroundEntity.swift
//  GoLarryGo
//
//  Created by aluno on 09/03/21.
//

import Foundation
import GameplayKit

class Ground: GKEntity {

    init(numberOfTiles: Int) {
        super.init()
        self.addComponent(TileRowComponent(numberOfTiles: numberOfTiles, assetName: "ground"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
