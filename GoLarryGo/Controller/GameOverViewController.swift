//
//  GameOverViewController.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit
class GameOverViewController: UIViewController {
    let gameOverView = GameOverView()
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
        view = gameOverView
        gameOverView.scoreLabel.text = "Score \(score)"
    }
}
