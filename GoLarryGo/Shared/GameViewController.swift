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
    
    var scene: GameScene!
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pause button"), for: .normal)
        return button
    }()

    override func loadView() {
        //super.viewDidLoad()
        let view = SKView(frame: UIScreen.main.bounds) //cria uma sk view
        self.scene = GameScene(size: view.bounds.size) //cria a scene que vai ser apresentada
       
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
        
        // Present the scene
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        self.view = view
        
        view.addSubview(pauseButton)
        setupPauseButton()
        configButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupPauseButton() {
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            pauseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            pauseButton.heightAnchor.constraint(equalToConstant: 44),
            pauseButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configButton() {
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    }
    
    @objc func pauseAction() {
        scene.isPaused = true
        scene.timer?.invalidate()
    }
    
}


