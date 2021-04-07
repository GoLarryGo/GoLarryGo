//
//  HomeViewController.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 17/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    weak var delegate: GameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        homeView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startGame))
        homeView.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            GameViewController.isHomeViewPresenting = false
        }

    @objc func startGame() {
        delegate?.startGame(viewController: self)
    }

}

extension HomeViewController: SoundButtonActionDelegate {
    func soundButtonTapped(sender: UIButton) {
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .buttonSound)
        SoundButtonHelper.sharedSoundButtonState.changeSoundButtonState()
        SoundButtonHelper.sharedSoundButtonState.setButtonImage(button: sender)
    }
    
    
}
