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
    func restartGame()
}

class GameViewController: UIViewController {
    
    static var isHomeViewPresenting: Bool = false
    static var scene: GameScene!
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
        
        GameViewController.scene = GameScene(size: view.bounds.size) //cria a scene que vai ser apresentada

        // Set the scale mode to scale to fit the window
        GameViewController.scene.scaleMode = .aspectFit

        // Present the scene
        view.presentScene(GameViewController.scene)
        view.ignoresSiblingOrder = true

        #if DEBUG
        view.showsFPS = true
        view.showsNodeCount = true
        #endif
        
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
        GameViewController.scene.isPaused = true
        GameViewController.scene.presentGameOver = presentGameOverViewController
        GameViewController.scene.pauseAction = pauseAction
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
        GameViewController.scene.isPaused = true
        ScoreView.startGame = false
        presentPauseViewController()
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        AVAudioPlayerManager.sharedPlayerManager.pauseSound(of: .soundtrack)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentHomeViewController()

    }

    func presentHomeViewController() {
            let homeVC = HomeViewController()
            homeVC.delegate = self
            present(homeVC, animated: false, completion: {
                GameViewController.isHomeViewPresenting = true
            })
        }
    
    func presentPauseViewController() {
        let pauseViewController = PauseViewController()
        pauseViewController.delegate = self
        present(pauseViewController, animated: false, completion: nil)
    }
    
    func presentGameOverViewController() {
        let score = scoreView.score
        let viewController = GameOverViewController(score: score)
        viewController.delegate = self

        present(viewController, animated: true)
    }
    
}

extension GameViewController: GameViewControllerDelegate {
    
    func reset() {
        GameViewController.scene.removeAllChildren()
        GameViewController.scene.removeAllActions()
        GameViewController.scene.removeFromParent()
        loadView()
        viewDidLoad()
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .soundtrack)
    }

    func resumeGame() {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .soundtrack)
        GameViewController.scene.isPaused = false
    }
    
    func exitGame() {
        // put scores to zero
        reset()
        ScoreView.startGame = false
        scoreView.score = 0
        presentHomeViewController()
        AVAudioPlayerManager.sharedPlayerManager.stopSound(of: .soundtrack)
    }
    
    func startGame(viewController: UIViewController) {
        GameViewController.scene.isPaused = false
        GameViewController.scene.customIsPaused = false
        ScoreView.startGame = true
        UIView.animate(withDuration: 0.1, animations: {
            viewController.view.alpha = 0.0
        }, completion: { _ in
            viewController.dismiss(animated: true, completion: nil)
        })
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .soundtrack)
    }
    
    func restartGame() {
        reset()
        scoreView.score = 0
        ScoreView.startGame = true
        GameViewController.scene.isPaused = false
    }

}
