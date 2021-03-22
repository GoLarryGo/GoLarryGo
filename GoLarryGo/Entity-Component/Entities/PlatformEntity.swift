//
//  PlatformEntity.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 20/03/21.
//

import Foundation
import GameplayKit

class Platform: GKEntity {

    init(numberOfTiles: Int) {
        super.init()
        self.addComponent(TileRowComponent(numberOfTiles: numberOfTiles, assetName: "metal"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
