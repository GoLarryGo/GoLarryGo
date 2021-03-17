//
//  HomeViewController.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 17/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
    }

}
