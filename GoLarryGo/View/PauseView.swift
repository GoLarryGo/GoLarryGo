//
//  PauseView.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/03/21.
//

import Foundation
import UIKit

protocol PauseViewButtonActionsDelegate: class {
    func soundButtonAction(sender: UIButton)
    func menuButtonAction(sender: UIButton)
    func resumeButtonAction(sender: UIButton)
    func closeButtonAction(sender: UIButton)
}

protocol PauseViewTapDelegate: class {
    func dismissPauseScreen()
}

class PauseView: UIView {
    
    var controller: PauseViewController?
    weak var delegate: PauseViewButtonActionsDelegate?
    weak var delegateTap: PauseViewTapDelegate?

    lazy var cardPause: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardSmall")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var labelResume: UILabel = {
        let label = UILabel()
        label.text = "Resume"
        label.font = UIFont(name: "PixelArial11", size: 13)
        label.textColor = .yellowText
        return label
    }()
    
    lazy var labelMenu: UILabel = {
        let label = UILabel()
        label.text = "Menu"
        label.font = UIFont(name: "PixelArial11", size: 13)
        label.textColor = .yellowText
        return label
    }()
    
    lazy var buttonResume: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.addTarget(self, action: #selector(resumeButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonSound: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        SoundButtonHelper.sharedSoundButtonState.setButtonImage(button: button)
        button.addTarget(self, action: #selector(soundButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    func setUpCardPauseConstraints() {
        cardPause.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardPause.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardPause.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardPause.widthAnchor.constraint(equalToConstant: 330 ),
            cardPause.heightAnchor.constraint(equalToConstant: 176 ),
        ])
    }
    
    func setUpButtonSoundConstraints() {
        buttonSound.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonSound.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 32),
            buttonSound.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonSound.widthAnchor.constraint(equalToConstant: 40),
            buttonSound.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpButtonCloseConstraints() {
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonClose.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 16),
            buttonClose.leftAnchor.constraint(equalTo: cardPause.leftAnchor, constant: 24),
            buttonClose.widthAnchor.constraint(equalToConstant: 40),
            buttonClose.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setUpButtonMenuConstraints() {
        buttonMenu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonMenu.topAnchor.constraint(equalTo: buttonSound.bottomAnchor, constant: 16),
            buttonMenu.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonMenu.widthAnchor.constraint(equalToConstant: 105),
            buttonMenu.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func setUpLabelMenuConstraints() {
        labelMenu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelMenu.centerXAnchor.constraint(equalTo: buttonMenu.centerXAnchor),
            labelMenu.centerYAnchor.constraint(equalTo: buttonMenu.centerYAnchor),
        ])
    }
    
    func setUpLabelResumeConstraints() {
        labelResume.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelResume.centerXAnchor.constraint(equalTo: buttonResume.centerXAnchor),
            labelResume.centerYAnchor.constraint(equalTo: buttonResume.centerYAnchor)
        ])
    }

    func setUpButtonResumeConstraints() {
        buttonResume.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonResume.topAnchor.constraint(equalTo: buttonMenu.bottomAnchor, constant: 16),
            buttonResume.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonResume.widthAnchor.constraint(equalToConstant: 105),
            buttonResume.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc func dismissPauseScreen(sender: UITapGestureRecognizer) {
        delegateTap?.dismissPauseScreen()
    }
    
    @objc func soundButtonAction(sender: UIButton) {
        delegate?.soundButtonAction(sender: buttonSound)
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        delegate?.menuButtonAction(sender: buttonMenu)
    }
    
    @objc func resumeButtonAction(sender: UIButton) {
        delegate?.resumeButtonAction(sender: buttonResume)
    }
    
    @objc func closeButtonAction(sender: UIButton) {
        delegate?.closeButtonAction(sender: buttonClose)
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
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPauseScreen))
        self.addGestureRecognizer(tap)
        setUpViewHierarchy()
        setUpCardPauseConstraints()
        setUpButtonCloseConstraints()
        setUpButtonSoundConstraints()
        setUpButtonMenuConstraints()
        setUpButtonResumeConstraints()
        setUpLabelResumeConstraints()
        setUpLabelMenuConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


