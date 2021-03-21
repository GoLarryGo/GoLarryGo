//
//  GenRobot.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 20/03/21.
//

import Foundation
import SpriteKit

protocol GenRobotPrototype {
    func clone() -> GenRobotPrototype
}

enum MetalType: Int {
    case test = 1
}

class GenMetal {
    
    func gerarPlat(position: CGPoint) -> [SKSpriteNode]? {
        let metal = Ground(numberOfTiles: 20, assetName: "metal")
        guard let metalTileRowComponent = metal.component(ofType: TileRowComponent.self) else {return nil}
        let metalTileNodes: [SKSpriteNode] = metalTileRowComponent.tileNodes.enumerated().map { (index, node) in
                node.size = CGSize(width: 32, height: 32)
                node.position = CGPoint(
                    x: position.x + (node.size.width * CGFloat(index)),
                    y: position.y
                )
                node.zPosition = ZPositionsCategories.ground
                node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width , height: node.size.height))
                node.physicsBody?.isDynamic = false
                return node
        }
        return metalTileNodes
    }
    
}
