//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isActiveRobotDead = false
    
    var entityManager: EntityManager!
    var presentGameOver: (() -> Void)?
    //Floor
    let ground = Ground(numberOfTiles: 80)
    var platformNodes: [SKSpriteNode] = []
    var countPlatform:Int = 1
    
    //Scenery
    var scenery = Scenery()
    var backNode = SKNode()
    var cloundsNode = SKNode()
    var montainFixNode = SKNode()
    var montainAltNode = SKNode()
    var sunNode = SKNode()
    
    //Update
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    let character = CharacterEntity()
    let robot = RobotEntity()
    
    let categoryCharacterPhysic: UInt32 = 1
    let categoryRobotPhysic: UInt32 = 1
    
    
    var characterPlayerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    var sceneryPlayerControlComponent: PlayerControlComponent? {
        ground.component(ofType: PlayerControlComponent.self)
    }
    
    var characterContactGround = false
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(jumpTap))
    @objc func jumpTap(_ sender: UITapGestureRecognizer) {
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterJumpState.self else { return }
        if characterContactGround {
            characterContactGround = false
            characterPlayerControlComponent?.jumpCharacter()
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        characterPlayerControlComponent?.startCharacter()
        
        entityManager = EntityManager(scene: self)
        
        view.addGestureRecognizer(tap)

        //Setups
        setupBackground()
        setupFloorPosition()
        setupCharacterNodePosition()
        
        generateRobot()
        
        //adding move to floor
//        let randomPlatforme = SKAction.run {
//            let numberXPlatform = Int.random(in: 5..<12)
//            self.setupPlatFormPosition(numberTiles: numberXPlatform, positionY: self.getPositionY() )
//        }
//        self.run(SKAction.repeatForever(SKAction.sequence([randomPlatforme, SKAction.wait(forDuration: 5.0)])))
    }
    
    func getPositionY() -> CGFloat {
        let sequencePositionY: CGFloat = 120
        countPlatform += 1
        if countPlatform % 2 == 0 && countPlatform % 3 != 0 && countPlatform % 5 != 0 {
            return sequencePositionY
        } else if countPlatform % 2 != 0 && countPlatform % 3 == 0 && countPlatform % 5 != 0 {
            return sequencePositionY + 50
        } else if countPlatform % 2 != 0 && countPlatform % 3 != 0 && countPlatform % 5 == 0 {
            return sequencePositionY + 100
        } else if countPlatform % 2 == 0 && countPlatform % 3 == 0 && countPlatform % 5 == 0{
            return sequencePositionY + 150
        } else {
            return sequencePositionY
        }
    }
    
    var activeMoveScenery: Bool = false
    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        characterPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        sceneryPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterDeadState.self else { return }
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode,
              let characterMove = character.component(ofType: MoveCharacterComponent.self) else {return}
        if characterSpriteNode.position.x > frame.midX {
            characterSpriteNode.position.x = frame.midX
            if !activeMoveScenery {
                setupSpeed(isDead: false)
                activeMoveScenery = true
                characterMove.halt()
            }
        } else {
            activeMoveScenery = false
            setupSpeed(isDead: true)
            characterMove.startMove()
        }
        
        if robotClones.count > 5 {
            guard let node = robotClones.first?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
            robotClones.removeFirst()
            node.removeFromParent()
        }
    }

    func setupSpeed(isDead: Bool) {
        guard let groundTileRowComponent = ground.component(ofType: TileRowComponent.self) else { return }
        if isDead {
            backNode.speed = 0
            montainFixNode.speed = 0
            montainAltNode.speed = 0
            cloundsNode.speed = 0
            groundTileRowComponent.stopMove()
        } else {
            backNode.speed = 1
            montainFixNode.speed = 0.5
            montainAltNode.speed = 0.5
            cloundsNode.speed = 1
            groundTileRowComponent.startMove()
        }
    }
    
    // MARK: - Adding Nodes to Scene
    func setupBackground() {
        //Scroll background
        var backgroundImage = SKSpriteNode()
                backgroundImage = SKSpriteNode(imageNamed: "back")
                backgroundImage.size = CGSize(width: self.size.width + 10, height: self.size.height)
                backgroundImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                backgroundImage.zPosition = ZPositionsCategories.background
                backNode.addChild(backgroundImage)
        self.addChild(backNode)
        
        //Scrool clounds
        var cloundsImage = SKSpriteNode()
            for i in 0..<2 {
                cloundsImage = SKSpriteNode(imageNamed: "clouds")
                cloundsImage.anchorPoint = CGPoint(x: 0, y: 0)
                cloundsImage.size = CGSize(width: self.size.width, height: self.size.height * 0.35)
                cloundsImage.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height * 0.5)
                cloundsImage.run(scenery.moveScenery(self.size))
                cloundsImage.zPosition = ZPositionsCategories.clounds
                cloundsNode.addChild(cloundsImage)
            }
        self.addChild(cloundsNode)
        
        //Scrool montainFix
        var montainFixImage = SKSpriteNode()
            for i in 0..<2 {
                montainFixImage = SKSpriteNode(imageNamed: "montainFix")
                montainFixImage.anchorPoint = CGPoint(x: 0, y: 0)
                montainFixImage.size = CGSize(width: self.size.width, height: self.size.height * 0.4)
                montainFixImage.position = CGPoint(x: self.size.width * CGFloat(i), y: 0)
                montainFixImage.run(scenery.moveScenery(self.size))
                montainFixImage.zPosition = ZPositionsCategories.montainFix
                montainFixNode.addChild(montainFixImage)
            }
        self.addChild(montainFixNode)
        
        //Scrool montainAlt
        var montainAltImage = SKSpriteNode()
            for i in 0..<2 {
                montainAltImage = SKSpriteNode(imageNamed: "montainAlt")
                montainAltImage.anchorPoint = CGPoint(x: 0, y: 0)
                montainAltImage.size = CGSize(width: self.size.width * 0.5, height: self.size.height * 0.5)
                montainAltImage.position = CGPoint(x: self.size.width * CGFloat(i), y: 15)
                montainAltImage.run(scenery.moveScenery(self.size))
                montainAltImage.zPosition = ZPositionsCategories.montainAlt
                montainAltNode.addChild(montainAltImage)
            }
        self.addChild(montainAltNode)
        
        //Sun
        var sunImage = SKSpriteNode()
                sunImage = SKSpriteNode(imageNamed: "sun")
                sunImage.anchorPoint = CGPoint(x: 0, y: 0)
                sunImage.size = CGSize(width: self.size.width * 0.15, height: self.size.height * 0.3)
                sunImage.position = CGPoint(x: self.size.width / 2.5 , y: self.size.height / 2)
                //sunImage.run(scenery.moveSun(self.size))
                sunImage.zPosition = ZPositionsCategories.sun
                sunNode.addChild(sunImage)
        self.addChild(sunNode)
    }
    
    func setupFloorPosition() {
        guard let groundTileRowComponent = ground.component(ofType: TileRowComponent.self) else {
            return
        }
        //initial positioning ground tiles
        let tileCount = groundTileRowComponent.tileNodes.count
        groundTileRowComponent.tileNodes = groundTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: node.texture!.size().width / 2 * offset,
                    y: 15
                )
                node.zPosition = ZPositionsCategories.ground
                node.size = CGSize(width: 32, height: 32)
                node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width, height: node.size.height))
                node.physicsBody?.isDynamic = false
                node.name = "ground"
                self.addChild(node)
                return node
        }
    }
    
    func setupPlatFormPosition(numberTiles: Int, positionY:CGFloat ) {
        let platform = Platform(numberOfTiles: numberTiles)
        guard let platformTileRowComponent = platform.component(ofType: TileRowComponent.self) else {
            return
        }
        //positioning platform tiles
        let tileCount = platformTileRowComponent.tileNodes.count
        let platformTileNodes: [SKSpriteNode] = platformTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: node.texture!.size().width / 2 * offset + self.size.width,
                    y: positionY
                )
                return node
        }
        //adding nodes to scene
            for platformNode in platformTileNodes {
                platformNode.zPosition = ZPositionsCategories.ground
                platformNode.size = CGSize(width: 32, height: 32)
                platformNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platformNode.size.width, height: platformNode.size.height))
                platformNode.physicsBody?.isDynamic = false
                platformNode.name = "platform"
                platformNode.run(scenery.movePlatform(self.size))
                platformNodes.append(platformNode)
                self.addChild(platformNode)
            }
    }
    
    func setupCharacterNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        //positioning character
        characterSpriteNode.position = CGPoint(x: 50, y: 60)
        characterSpriteNode.size = CGSize(width: 64, height: 64)
        
        characterSpriteNode.physicsBody?.categoryBitMask = categoryCharacterPhysic
        characterSpriteNode.physicsBody?.collisionBitMask = categoryRobotPhysic
        characterSpriteNode.physicsBody?.contactTestBitMask = categoryRobotPhysic
        
        characterSpriteNode.name = "character"
        
        entityManager.add(character)
    }
    
    //MARK: - Generate Robot Clone
    var robotClones: [RobotEntity] = []
    
    func generateRobot() {
        let generate = SKAction.run {
            let cloneRobot: RobotEntity = self.robot.copy() as! RobotEntity
            self.configureRobotCloneNodePosition(entity: cloneRobot, position: CGPoint(x: 1000, y: 60))
            guard let moveCloneRobot = cloneRobot.component(ofType: MoveRobotComponent.self) else {return}
            moveCloneRobot.startMove(direction: .left)
            self.robotClones.append(cloneRobot)
        }
        self.run(SKAction.repeatForever(SKAction.sequence([generate, SKAction.wait(forDuration: 5.0)])))
    }
    
    func configureRobotCloneNodePosition(entity: RobotEntity, position: CGPoint) {
        guard let robotSpriteNode = entity.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        robotSpriteNode.position = position
        robotSpriteNode.physicsBody?.categoryBitMask = 1
        robotSpriteNode.physicsBody?.contactTestBitMask = 1
        robotSpriteNode.name = "robot"
        addChild(robotSpriteNode)
    }

}


extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {

        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else {return}
        
        var nodeCharacter = SKNode()
        var nodeRobot = SKNode()
        if nodeA.name == "character" && nodeB.name == "robot" {
            nodeCharacter = nodeA
            nodeRobot = nodeB
        } else if nodeA.name == "robot" && nodeB.name == "character" {
            nodeCharacter = nodeB
            nodeRobot = nodeA
        }
        
        if  nodeA.name == "character" && nodeB.name == "robot" ||
            nodeA.name == "robot" && nodeB.name == "character" {
            
            print("nodeA: \(nodeA.position.y)    nodeB: \(nodeB.position.y + 32)")
            if !self.isActiveRobotDead {
                if nodeCharacter.position.y > nodeRobot.position.y + 32 {
                    
                        self.isActiveRobotDead = true
                            robotClones.forEach { robot in
                                guard let component = robot.component(ofType: AnimatedSpriteComponent.self) else {return}
                                if nodeB.isEqual(to: component.spriteNode) {
                                    component.setAnimationSingle(atlasName: "robotDead", direction: true)
                                    component.spriteNode.removeAllActions()
                                    nodeRobot.run(SKAction.wait(forDuration: 0.15)) {
                                        component.spriteNode.removeFromParent()
                                        self.isActiveRobotDead = false
                                    }
                                }
                            }
                    
                } else {
                    stopGame()
                }
            }
        }
        
        if  nodeA.name == "character" && nodeB.name == "ground"     ||
            nodeA.name == "character" && nodeB.name == "platform"   ||
            nodeB.name == "character" && nodeA.name == "ground"     ||
            nodeB.name == "character" && nodeA.name == "platform" {
                print("iniciou contato")
                characterContactGround = true
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else {return}
        
        if  nodeA.name == "character" && nodeB.name == "platform" ||
            nodeB.name == "character" && nodeA.name == "platform" {
                print("cabou contato")
                characterContactGround = false
        }
    }
    
    func stopGame() {
        characterPlayerControlComponent?.deadCharacter()
        setupSpeed(isDead: true)
        ScoreView.startGame = false
        let gameOverRun = SKAction.run {
            guard let gameOver = self.presentGameOver else {return}
            self.isPaused = true
            gameOver()
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), gameOverRun]))
        robotClones.forEach { robot in
            guard let robotMove = robot.component(ofType: MoveRobotComponent.self) else {return}
            robotMove.startMove(direction: .none)
        }
    }
}
