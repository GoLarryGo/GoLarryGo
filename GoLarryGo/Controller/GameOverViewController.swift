//
//  GameOverViewController.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit
class GameOverViewController: UIViewController {
    let gameOverView = GameOverView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = gameOverView
    }
}
