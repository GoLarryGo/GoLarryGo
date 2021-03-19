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
    
    override func loadView() {
        super.loadView()
        let pauseView = PauseView()
        pauseView.controller = self
        pauseView.delegate = self
        self.view = pauseView
    }

}

extension PauseViewController: PauseViewButtonActionsDelegate {
    
    func soundButtonAction(sender: UIButton) {
        print("a")
    }
    
    func menuButtonAction(sender: UIButton) {
//       go to menu
        print("b")
    }

    func resumeButtonAction(sender: UIButton) {
//     go back to the game
        print("c")
    }

    func closeButtonAction(sender: UIButton) {
//       go back to the game
        print("d")
    }

    
}

