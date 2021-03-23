//
//  TileRowComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 15/03/21.
//

import Foundation
import GameplayKit

class TileRowComponent: GKComponent {
    var move: Bool = false
    let numberOfTiles: Int
    var tileNodes: [SKSpriteNode] = []

    init(numberOfTiles tiles: Int, assetName: String) {
        self.numberOfTiles = tiles
        for _ in 0..<tiles {
            self.tileNodes.append(SKSpriteNode(imageNamed: assetName))
        }
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopMove() {
        self.move = false
    }
    
    func startMove() {
        self.move = true
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if move {
            var i = 0
            for node in tileNodes {
                node.position.x -= 1
                let offset = CGFloat(tileNodes.count/2 - i)
                if node.position.x < 32 * offset {
                    node.position.x += 1000
                }
                i += 1
            }
        } else {
            for node in tileNodes {
                node.position.x -= 0
            }
        }
    }

}
