//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var customIsPaused: Bool = false
    var homeViewController: UIViewController?
    var pauseAction: (()-> Void)?
    
    var isActiveRobotDead = false
    
    var entityManager: EntityManager!
    var presentGameOver: (() -> Void)?
    //Floor
    var countPlatform:Int = 1
    
    //Scenery
    var scenery = Scenery()
    var backNode = SKNode()
    var cloundsNode = SKNode()
    var sunNode = SKNode()
    
    //MARK: - Generate Robot Clone
    var robotClones: [RobotEntity] = []
    var platformsClones: [Platform] = []
    var grounds: [GroundEntity] = []
    
    //Update
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    let character = CharacterEntity()
    let robot = RobotEntity()
    let scenaryEntity = ScenaryEntity()
    
    let categoryCharacterPhysic: UInt32 = 1
    let categoryRobotPhysic: UInt32 = 1
    
    var characterPlayerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    var scenaryPlayerControlComponent: PlayerControlComponent? {
        scenaryEntity.component(ofType: PlayerControlComponent.self)
    }
    
    var characterContactGround = false
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        characterPlayerControlComponent?.startCharacter()
        
        entityManager = EntityManager(scene: self)
        
        //Setups
        setupBackground()
        setupScenary()
        addNodesScenary()
        setupGroundPosition()
        setupCharacterNodePosition()
    }
    
    //MARK: - Initial logic of randomization
    var activeOne = false
    func platformCasesTests() {
        if !activeOne {
            activeOne = true
            //adding move to floor
            let randomPlatforme = SKAction.run {
                self.randomCasesPlatformsAndRobot()
            }
            self.run(SKAction.repeatForever(SKAction.sequence([randomPlatforme, SKAction.wait(forDuration: 15.0)])))
        }
    }
    
    func randomCasesPlatformsAndRobot() {
        let numberXPlatform = Int.random(in: 8..<10)
        let random = Int.random(in: 1...5)
        self.casesPlatformsAndRobot(random: random, numberTiles: numberXPlatform)
    }
    
    func hideGroundPlatform(numberTiles: Int, first: CGFloat) {
        var countTile = 0
        grounds.forEach { block in
            guard let node = block.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
            if (node.position.x >= first && countTile < numberTiles * 32) {
                countTile += 32
                node.isHidden = true
                node.physicsBody = nil
            }
        }
    }
    
    func casesPlatformsAndRobot(random: Int, numberTiles: Int) {
        switch random {
        case 1:
            let robotPosition = CGPoint(x: (size.width + CGFloat(numberTiles / 2 * 32)), y: 170.0)
            robotAndPlatformTypeOne(robotPosition: robotPosition, numberTiles: numberTiles, platformHeigth: 120.0)
            hideGroundPlatform(numberTiles: numberTiles, first: size.width)
            break
        case 2:
            var robotPosition = CGPoint(x: (size.width + CGFloat(numberTiles / 2 * 32)), y: 70.0)
            if Int.random(in: 1...2) == 1 {
                robotAndPlatformTypeOne(robotPosition: robotPosition, numberTiles: numberTiles, platformHeigth: 120.0)
            } else {
                robotPosition.x = (size.width + CGFloat(numberTiles * 32))
                robotAndPlatformTypeTwo(robotPosition: robotPosition, numberTiles: numberTiles, platformHeigth: 120.0)
            }
            break
        case 3:
            let robotPosition = CGPoint(x: (size.width + CGFloat(numberTiles / 2 * 32)), y: 70.0)
            robotAndPlatformTypeOne(robotPosition: robotPosition, numberTiles: numberTiles, platformHeigth: 120.0)
            
            robotAndPlatformTypeOne(robotPosition: nil, numberTiles: numberTiles, platformHeigth: 200.0, platformBegin: CGFloat(numberTiles * 30))
            hideGroundPlatform(numberTiles: numberTiles, first: CGFloat(numberTiles * 30) + size.width)
            break
        case 4:
            let robotPosition = CGPoint(x: (size.width + CGFloat(numberTiles / 2 * 32)), y: 70.0)
            robotAndPlatformTypeOne(robotPosition: robotPosition, numberTiles: numberTiles, platformHeigth: 120.0)
            
            let robotPosition2 = CGPoint(x: (size.width + CGFloat(numberTiles * 29)), y: 170.0)
            robotAndPlatformTypeOne(robotPosition: robotPosition2, numberTiles: numberTiles, platformHeigth: 200.0, platformBegin: CGFloat(numberTiles * 30))
            break
        case 5:
            robotAndPlatformTypeOne(robotPosition: nil, numberTiles: numberTiles, platformHeigth: 120.0)
            
            robotAndPlatformTypeOne(robotPosition: nil, numberTiles: numberTiles, platformHeigth: 200.0, platformBegin: CGFloat(numberTiles * 30))
            hideGroundPlatform(numberTiles: numberTiles, first: CGFloat(numberTiles * 30) + size.width)
            break
        default: break
        }
    }
    
    func robotConfigure(robot: RobotEntity, position: CGPoint, reverse: Bool = false) {
        guard let robotNode = robot.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else { fatalError() }
        robotNode.physicsBody?.isDynamic = true
        if reverse {
            robotNode.xScale = -1
        }
        robotNode.position = position
        robotNode.physicsBody?.categoryBitMask = 1
        robotNode.physicsBody?.contactTestBitMask = 1
        robotNode.name = "robot"
        addChild(robotNode)
    }
    
    func robotAndPlatformTypeOne(robotPosition: CGPoint?, numberTiles: Int, platformHeigth: CGFloat, platformBegin: CGFloat = 0) {
        let platform = Platform(numberOfTiles: numberTiles)
        setupPlatFormPosition(platform: platform, positionY: platformHeigth, begin: platformBegin)
        guard let robotPosition = robotPosition else {return}
        let robot = RobotEntity(name: "robotIdle")
        robotConfigure(robot: robot, position: robotPosition, reverse: true)
        guard let robotMove = robot.component(ofType: MoveRobotComponent.self) else {return}
        robotMove.changeVelocity(velocity: 10.0)
        robotMove.startMove(direction: .left, robotType: "robotIdle")
        robotClones.append(robot)
    }
    
    func robotAndPlatformTypeTwo(robotPosition: CGPoint?, numberTiles: Int, platformHeigth: CGFloat, platformBegin: CGFloat = 0) {
        let platform = Platform(numberOfTiles: numberTiles)
        setupPlatFormPosition(platform: platform, positionY: platformHeigth, begin: platformBegin)
        guard let robotPosition = robotPosition else {return}
        let robot = RobotEntity(name: "robotWalkLeft")
        robotConfigure(robot: robot, position: robotPosition)
        guard let robotMove = robot.component(ofType: MoveRobotComponent.self) else {return}
        robotMove.changeVelocity(velocity: 15.0)
        robotMove.startMove(direction: .left)
        robotClones.append(robot)
    }
    //MARK: - End logic of randomization
    
    var activeMoveScenery: Bool = false
    override func update(_ currentTime: TimeInterval) {
        
        // Pause controll
        if self.customIsPaused {
            isPaused = true
            if !GameViewController.isHomeViewPresenting {
                pauseAction?()
                customIsPaused = false
            }
            
            return
        }
        
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        characterPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        scenaryPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterDeadState.self else { return }
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode,
              let characterMove = character.component(ofType: MoveCharacterComponent.self) else {return}
        if characterSpriteNode.position.x + 2 >= frame.midX {
            characterSpriteNode.position.x = frame.midX
            if !activeMoveScenery {
                setupSpeed(isDead: false)
                activeMoveScenery = true
                characterMove.halt()
                platformCasesTests()
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
        
        if platformsClones.count > 4 {
            guard let nodes = platformsClones.first?.component(ofType: TileRowComponent.self)?.tileNodes else {return}
            platformsClones.removeFirst()
            nodes.forEach { node in
                node.removeFromParent()
            }
        }
        
        guard let node = grounds.first?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        if node.position.x < -32 {
            grounds.removeFirst()
            addNewBlock(activeMove: true)
            node.removeFromParent()
        }
        
        guard let tilesScenary = scenaryEntity.component(ofType: TileRowComponent.self),
              let moveScenary = scenaryEntity.component(ofType: MoveScenaryComponent.self) else { return }
        
        if tilesScenary.tileNodes.first?.position.x == size.width {
            moveScenary.stopMove()
            setupScenary()
            moveScenary.startMove()
        }
        
    }
    
    func setupSpeed(isDead: Bool) {
        guard let scenaryMoveComponent = scenaryEntity.component(ofType: MoveScenaryComponent.self) else { return }
        if isDead {
            backNode.speed = 0
            cloundsNode.speed = 0
            scenaryMoveComponent.stopMove()
            moveGroundStop()
        } else {
            backNode.speed = 1
            cloundsNode.speed = 1
            scenaryMoveComponent.startMove()
            moveGroundStart()
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
        
        //Sun
        var sunImage = SKSpriteNode()
        sunImage = SKSpriteNode(imageNamed: "sun")
        sunImage.anchorPoint = CGPoint(x: 0, y: 0)
        sunImage.size = CGSize(width: self.size.width * 0.15, height: self.size.height * 0.3)
        sunImage.position = CGPoint(x: self.size.width / 2.5 , y: self.size.height / 2)
        sunImage.zPosition = ZPositionsCategories.sun
        sunNode.addChild(sunImage)
        self.addChild(sunNode)
    }
    
    func setupScenary() {
        guard let scenaryTileRowComponent = scenaryEntity.component(ofType: TileRowComponent.self) else { return }
        
        let tileCount = scenaryTileRowComponent.tileNodes.count
        scenaryTileRowComponent.tileNodes = scenaryTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: (size.width - 5) * offset,
                    y: size.height / 4
                )
                node.size = CGSize(width: size.width, height: size.height * 0.5)
                node.zPosition = ZPositionsCategories.montainFix
                return node
        }
    }
    
    func addNodesScenary() {
        guard let scenaryTileRowComponent = scenaryEntity.component(ofType: TileRowComponent.self) else { return }
        scenaryTileRowComponent.tileNodes.forEach { node in
            addChild(node)
        }
    }
    
    
    //MARK: - Initial Setup Ground
    func setupGroundPosition() {
        for _ in 0..<80 {
            addNewBlock()
        }
    }
    
    func addNewBlock(activeMove: Bool = false) {
        let block = GroundEntity()
        guard let node = block.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        node.zPosition = ZPositionsCategories.ground
        node.size = CGSize(width: 32, height: 32)
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width, height: node.size.height))
        node.physicsBody?.isDynamic = false
        node.name = "ground"
        
        node.position = CGPoint(
            x: grounds.count * 32,
            y: 15
        )
        
        if activeMove {
            guard let move = block.component(ofType: MoveGroundComponent.self) else {return}
            move.startMove()
        }
        
        grounds.append(block)
        addChild(node)
    }
    
    func moveGroundStart() {
        grounds.forEach { block in
            guard let moveBlock = block.component(ofType: MoveGroundComponent.self) else {return}
            moveBlock.startMove()
        }
    }
    
    func moveGroundStop() {
        grounds.forEach { block in
            guard let moveBlock = block.component(ofType: MoveGroundComponent.self) else {return}
            moveBlock.stopMove()
        }
    }
    //MARK: - End Setup Ground
    
    func setupPlatFormPosition(platform: Platform, positionY: CGFloat, begin: CGFloat = 0.0) {
        
            guard let platformTileRowComponent = platform.component(ofType: TileRowComponent.self),
                  let movePlatform = platform.component(ofType: MovePlatformComponent.self)else {return}
            
            var incrementXPositionPlataform = self.size.width + begin
            platformTileRowComponent.tileNodes = platformTileRowComponent.tileNodes.enumerated().map { (index, node) in
                
                node.position = CGPoint(
                    x: incrementXPositionPlataform ,
                    y: positionY
                )
                incrementXPositionPlataform += node.texture!.size().width/2
                
                node.zPosition = ZPositionsCategories.ground
                node.size = CGSize(width: 32, height: 32)
                node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width, height: node.size.height))
                node.physicsBody?.isDynamic = false
                node.name = "platform"
                self.addChild(node)
                
                return node
            }

            movePlatform.startMove()
            platformsClones.append(platform)
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
}


extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterJumpState.self else { return }
        if characterContactGround {
            characterContactGround = false
            characterPlayerControlComponent?.jumpCharacter()
        }
    }
    
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
            
            //print("nodeA: \(nodeA.position.y)    nodeB: \(nodeB.position.y + 32)")
            if !self.isActiveRobotDead {
                if nodeCharacter.position.y > nodeRobot.position.y + 32 {
                    
                    self.isActiveRobotDead = true
                    robotClones.forEach { robot in
                        guard let component = robot.component(ofType: AnimatedSpriteComponent.self) else {return}
                        if nodeB.isEqual(to: component.spriteNode) {
                            component.setAnimationSingle(atlasName: "robotDead", direction: true)
                            AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .dyingRobot)
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
                characterContactGround = true
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else {return}
        
        if  nodeA.name == "character" && nodeB.name == "platform" ||
            nodeB.name == "character" && nodeA.name == "platform" {
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
        platformsClones.forEach { platform in
            guard let platformMove = platform.component(ofType: MovePlatformComponent.self) else {return}
            platformMove.stopMove()
        }
        robotClones.forEach { robot in
            guard let robotMove = robot.component(ofType: MoveRobotComponent.self) else {return}
            robotMove.startMove(direction: .none)
        }
        
    }
}
