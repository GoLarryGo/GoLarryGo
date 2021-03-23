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

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear() {
        if view.frame.origin.y >= 0 {
            view.frame.origin.y -= 150
        }
    }

    @objc func keyboardWillDisappear() {
        view.frame.origin.y += 150
    }

}

//extension GameOverViewController:  {
//
//}
