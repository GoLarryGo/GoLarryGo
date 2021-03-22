//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entityManager: EntityManager!
   
    //Floor
    let ground = Ground(numberOfTiles: 120)
    var groundNodes: [SKSpriteNode] = []
    
    //Scenery
    var scenery = Scenery()
    var backNode = SKNode()
    var cloundsNode = SKNode()
    var montainFixNode = SKNode()
    var montainAltNode = SKNode()
    var sunNode = SKNode()
    
    //Update
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    //Points
    let pointsLabel = SKLabelNode(fontNamed: "PixelArt11")
    var points: Int = 0 {
        didSet {
            pointsLabel.text = "Score: \(points)"
        }
    }
    
    //Timer
    var timerScore: Timer?

    //game over
    var gameOver: Bool = false
    
    let character = CharacterEntity()
    let robot = RobotEntity()
    
    let categoryCharacterPhysic: UInt32 = 1
    let categoryRobotPhysic: UInt32 = 1
    
    
    var characterPlayerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    var robotPlayerControlComponent: PlayerControlComponent? {
        robot.component(ofType: PlayerControlComponent.self)
    }
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(jumpTap))
    @objc func jumpTap(_ sender: UITapGestureRecognizer) {
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterJumpState.self else { return }
        characterPlayerControlComponent?.jumpCharacter()
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
        
        characterPlayerControlComponent?.startCharacter()
        robotPlayerControlComponent?.startRobot()
        
        entityManager = EntityManager(scene: self)
        
        view.addGestureRecognizer(tap)
        
        if timerScore == nil {
          let timer = Timer(timeInterval: 1.0,
                            target: self,
                            selector: #selector(updateTimer),
                            userInfo: nil,
                            repeats: true)
          RunLoop.current.add(timer, forMode: .common)
          self.timerScore = timer
        }
        
        //Points
        pointsLabel.horizontalAlignmentMode = .right
        pointsLabel.verticalAlignmentMode = .top
        pointsLabel.color = .white
        pointsLabel.position = CGPoint(x:frame.maxX-95 ,y:frame.maxY-35)
        pointsLabel.zPosition = ZPositionsCategories.points
        self.addChild(pointsLabel)
        
        //Setups
        setupBackground()
        setupFloorPosition()
        setupCharacterNodePosition()
        setupRobotNodePosition()
        
        //SpeedBackground
        setupSpeed(isDead: true)
        
        //adding move to floor
//            for groundNode in groundNodes {
//                groundNode.run(scenery.moveGround(self.size))
//            }
    }
    
    var activeMoveScenery: Bool = false
    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        characterPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
        
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode,
              let characterMoveComponent = character.component(ofType: MoveCharacterComponent.self) else {return}
        if characterSpriteNode.position.x > (view?.center.x)! && activeMoveScenery == false {
            characterMoveComponent.halt()
            setupSpeed(isDead: false)
            for groundNode in groundNodes {
                groundNode.run(scenery.moveGround(self.size))
            }
            activeMoveScenery = true
        }
        
        if gameOver == true {
            print("Game Over!")
        }
    }

    
    
    func setupSpeed(isDead: Bool) {
        if isDead {
            backNode.speed = 0
            montainFixNode.speed = 0
            montainAltNode.speed = 0
            cloundsNode.speed = 0
        } else {
            backNode.speed = 1
            montainFixNode.speed = 0.5
            montainAltNode.speed = 0.5
            cloundsNode.speed = 1
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
        let groundTileNodes: [SKSpriteNode] = groundTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: node.texture!.size().width / 2 * offset,
                    y: 15
                )
                return node
        }
        //adding nodes to scene
            for groundNode in groundTileNodes {
                groundNode.zPosition = ZPositionsCategories.ground
                groundNode.size = CGSize(width: 32, height: 32)
                groundNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundNode.size.width * 2, height: groundNode.size.height * 2))
                groundNode.physicsBody?.isDynamic = false
                groundNode.name = "ground"
                groundNodes.append(groundNode)
                self.addChild(groundNode)
            }
    }

            @objc func updateTimer() {
                if let timer = timerScore {
                    self.points += Int(timer.timeInterval)
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
    
    func setupRobotNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let robotSpriteNode = robot.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning character
        robotSpriteNode.position = CGPoint(x: 800, y: 60)
        robotSpriteNode.size = CGSize(width: 64, height: 64)
        
        robotSpriteNode.physicsBody?.categoryBitMask = categoryRobotPhysic
        robotSpriteNode.physicsBody?.contactTestBitMask = categoryCharacterPhysic
        
        robotSpriteNode.name = "robot"
        
        entityManager.add(robot)
    }
    
    func configureRobotCloneNodePosition(entity: RobotEntity, size: CGSize, position: CGPoint) {
        //acessing character from AnimatedSpriteComponents
        guard let robotSpriteNode = entity.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning character
        robotSpriteNode.position = position
        robotSpriteNode.size = size
        
        robotSpriteNode.physicsBody?.categoryBitMask = 2
        robotSpriteNode.physicsBody?.contactTestBitMask = 1
        
        robotSpriteNode.name = "robot"
    }

}

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "character" && nodeB.name == "robot" {
            print("teve contato conditinal 1 - A: \(nodeA.position.y) [] B: \(nodeB.position.y)")
            if nodeA.position.y > nodeB.position.y {
                robotPlayerControlComponent?.deadRobot()
            } else {
                characterPlayerControlComponent?.deadCharacter()
                stopScenery()
            }
        }
        if nodeA.name == "robot" && nodeB.name == "character" {
            print("teve contato conditional 2 - A: \(nodeA.position.y) [] B: \(nodeB.position.y)")
            if nodeB.position.y > nodeA.position.y {
                robotPlayerControlComponent?.deadRobot()
            } else {
                characterPlayerControlComponent?.deadCharacter()
                stopScenery()
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //print("acabou contato")
    }
    
    func stopScenery() {
        setupSpeed(isDead: true)
        self.timerScore?.invalidate()
        gameOver = true
        for groundNode in groundNodes {
            groundNode.removeAllActions()
        }
    }
}
