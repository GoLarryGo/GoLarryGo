//
//  ScoreView.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 18/03/21.
//
import Foundation
import UIKit
import SpriteKit

class ScoreViewController: UIViewController {
  override func loadView() {
        super.loadView()
        let scoreView = ScoreView()
        scoreView.controller = self
        self.view = scoreView
    }
}

