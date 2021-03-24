//
//  PauseViewController.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/03/21.
//

import Foundation
import UIKit
import SpriteKit

class PauseViewController: UIViewController {
    
    weak var delegate: GameViewControllerDelegate?
    override func loadView() {
        super.loadView()
        let pauseView = PauseView()
        pauseView.controller = self
        pauseView.delegate = self
        pauseView.delegateTap = self
        self.view = pauseView
    }
    
    func dismissPauseView() {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 0.0
        }, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension PauseViewController: PauseViewButtonActionsDelegate {
    
    func soundButtonAction(sender: UIButton) {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        SoundButtonHelper.sharedSoundButtonState.changeSoundButtonState()
        SoundButtonHelper.sharedSoundButtonState.setButtonImage(button: sender)
    }
    
    func menuButtonAction(sender: UIButton) {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        dismissPauseView()
        delegate?.exitGame()
    }
    
    func resumeButtonAction(sender: UIButton) {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        dismissPauseView()
        delegate?.resumeGame()
    }
    
    func closeButtonAction(sender: UIButton) {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        dismissPauseView()
        delegate?.resumeGame()
    }
    
}

extension PauseViewController: PauseViewTapDelegate {
    func dismissPauseScreen() {
        dismissPauseView()
        delegate?.resumeGame()
    }
}
