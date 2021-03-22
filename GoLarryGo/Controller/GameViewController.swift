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
    func resumeGame()
    func exitGame()
}

class GameViewController: UIViewController {
    
    var scene: GameScene!
    let scoreView = ScoreView()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pause button"), for: .normal)
        return button
    }()

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
        
        //Adiciona os scores na scene
        view.addSubview(scoreView.labelScore)
        setUpLabelScoreConstraints()

        //Adiciona o botão de pause
        view.addSubview(pauseButton)
        setupPauseButton()
        configButton()
        
    }

    override func viewDidLoad() {
        scene.isPaused = true
    }
    func setUpLabelScoreConstraints() {
        NSLayoutConstraint.activate([
            scoreView.labelScore.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            scoreView.labelScore.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        ])
    }
    
    func setupPauseButton() {
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            pauseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            pauseButton.heightAnchor.constraint(equalToConstant: 44),
            pauseButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configButton() {
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    }

    @objc func pauseAction() {
        scene.isPaused = true
        scoreView.timer?.invalidate()
        presentPauseViewController()
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
    
    func presentPauseViewController() {
        let pauseViewController = PauseViewController()
        pauseViewController.delegate = self
        present(pauseViewController, animated: false, completion: nil)
    }
    
}

extension GameViewController: GameViewControllerDelegate {

    func resumeGame() {
        self.scene.isPaused = false
    }
    
    func exitGame() {
        // put scores to zero
        self.scene.isPaused = true
        presentHomeViewController()
    }
    
    func startGame(viewController: UIViewController) {
        scene.isPaused = false
        ScoreView.startGame = true
        UIView.animate(withDuration: 0.1, animations: {
            viewController.view.alpha = 0.0
        }, completion: { _ in
            viewController.dismiss(animated: true, completion: nil)
        })
    }

}
