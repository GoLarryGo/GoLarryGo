//
//  GameOverViewController.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit
class GameOverViewController: UIViewController {
    let gameOverView = GameOverView()
    weak var delegate: GameViewControllerDelegate?

    let score: Int

    init(score: Int) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameOverView.smallCard.buttonMenu.addTarget(self, action: #selector(presentMenuViewController), for: .touchDown)
        gameOverView.smallCard.buttonRestart.addTarget(self, action: #selector(presentRestartViewController), for: .touchDown)
        
        view = gameOverView
        gameOverView.delegate = self
        gameOverView.smallCard.scoreLabel.text = "Score \(score)"
    }

}

extension GameOverViewController: GameOverViewDelegate {
    @objc func presentMenuViewController() {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 0.0
        }, completion: nil)
        self.dismiss(animated: false, completion: nil)
        delegate?.exitGame()
        
    }
    @objc func presentRestartViewController() {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 0.0
        }, completion: nil)
        self.dismiss(animated: false, completion: nil)
        delegate?.restartGame()
    }

}
