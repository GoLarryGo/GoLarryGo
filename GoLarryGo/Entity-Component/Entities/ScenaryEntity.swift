//
//  ScenaryEntity.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 06/04/21.
//


import Foundation
import GameplayKit

class ScenaryEntity: GKEntity {

    override init() {
        super.init()
        addComponent(TileRowComponent(numberOfTiles: 5, assetName: "montain"))
        addComponent(MoveScenaryComponent(velocity: 2))
        addComponent(PlayerControlComponent(states: []))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
