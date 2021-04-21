//
//  GameOverViewController.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit
import GameKit

class GameOverViewController: UIViewController {
    
    /* Variables */
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
         
    // IMPORTANT: replace the red string below with your own Leaderboard ID (the one you've set in iTunes Connect)
    let LEADERBOARD_ID = "com.score.goLarryGo"
    
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
        
        // Call the GC authentication controller
        authenticateLocalPlayer()
        
        addScoreAndSubmitToGC()
    }
    // MARK: - AUTHENTICATE LOCAL PLAYER
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
             
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                     
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error!)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                 
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
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

extension GameOverViewController: GKGameCenterControllerDelegate{

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - SUBMIT THE UPDATED SCORE TO GAME CENTER
    func addScoreAndSubmitToGC() {
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
        bestScoreInt.value = Int64(score)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }
    
    func checkGCLeaderboard() {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }
    
}
