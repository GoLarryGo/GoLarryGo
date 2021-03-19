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

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startGame))
        homeView.addGestureRecognizer(tapRecognizer)
    }

    @objc func startGame() {
        delegate?.startGame(viewController: self)
    }

}
