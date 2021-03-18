//
//  GameViewController.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerDelegate: class {
    func startGame(viewController: UIViewController)
}

class GameViewController: UIViewController {

    var scene: GameScene!

    override func loadView() {
        //super.viewDidLoad()
        let view = SKView(frame: UIScreen.main.bounds) //cria uma sk view
        scene = GameScene(size: view.bounds.size) //cria a scene que vai ser apresentada

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
        scene.isPaused = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentHomeViewController()

    }

    func presentHomeViewController() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        present(homeVC, animated: false, completion: nil)
    }
    

}

extension GameViewController: GameViewControllerDelegate {
    func startGame(viewController: UIViewController) {
        self.scene.isPaused = false

        UIView.animate(withDuration: 0.1, animations: {
            viewController.view.alpha = 0.0
        }, completion: { _ in
            viewController.dismiss(animated: true, completion: nil)
        })
    }

}
