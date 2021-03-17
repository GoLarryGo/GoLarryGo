//
//  GameViewController.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func loadView() {
        //super.viewDidLoad()
        let view = SKView(frame: UIScreen.main.bounds) //cria uma sk view
        let scene = GameScene(size: view.bounds.size) //cria a scene que vai ser apresentada
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
        
        // Present the scene
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


