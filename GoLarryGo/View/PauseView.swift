//
//  PauseView.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/03/21.
//

import Foundation
import UIKit

class PauseView: UIView {
    
    var controller: PauseViewController?
    
    lazy var cardPause: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardSmall")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var labelResume: UILabel = {
        let label = UILabel()
        label.text = "Resume"
        label.textColor = .yellowText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelMenu: UILabel = {
        let label = UILabel()
        label.text = "Menu"
        label.textColor = .yellowText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonResume: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonSound: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sound on"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            cardPause.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardPause.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardPause.widthAnchor.constraint(equalToConstant: 330 ),
            cardPause.heightAnchor.constraint(equalToConstant: 176 ),
            
            buttonClose.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 16),
            buttonClose.leftAnchor.constraint(equalTo: cardPause.leftAnchor, constant: 24),
            buttonClose.widthAnchor.constraint(equalToConstant: 40),
            buttonClose.heightAnchor.constraint(equalToConstant: 40),
            
            buttonSound.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 32),
            buttonSound.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonSound.widthAnchor.constraint(equalToConstant: 40),
            buttonSound.heightAnchor.constraint(equalToConstant: 40),
            
            buttonMenu.topAnchor.constraint(equalTo: buttonSound.bottomAnchor, constant: 16),
            buttonMenu.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonMenu.widthAnchor.constraint(equalToConstant: 105),
            buttonMenu.heightAnchor.constraint(equalToConstant: 28),
            
            labelMenu.centerXAnchor.constraint(equalTo: buttonMenu.centerXAnchor),
            labelMenu.centerYAnchor.constraint(equalTo: buttonMenu.centerYAnchor),
            
            buttonResume.topAnchor.constraint(equalTo: buttonMenu.bottomAnchor, constant: 16),
            buttonResume.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonResume.widthAnchor.constraint(equalToConstant: 105),
            buttonResume.heightAnchor.constraint(equalToConstant: 28),
            
            labelResume.centerXAnchor.constraint(equalTo: buttonResume.centerXAnchor),
            labelResume.centerYAnchor.constraint(equalTo: buttonResume.centerYAnchor)
        ])
    }
    
    func setUpViewHierarchy(){
        self.addSubview(cardPause)
        
        cardPause.addSubview(buttonClose)
        cardPause.addSubview(buttonSound)
        cardPause.addSubview(buttonMenu)
        buttonMenu.addSubview(labelMenu)
        cardPause.addSubview(buttonResume)
        buttonResume.addSubview(labelResume)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        setUpViewHierarchy()
        setUpConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
