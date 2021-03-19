//
//  PauseView.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/03/21.
//

import Foundation
import UIKit


protocol PauseViewButtonActionsDelegate{
    func soundButtonAction(sender: UIButton)
    func menuButtonAction(sender: UIButton)
    func resumeButtonAction(sender: UIButton)
    func closeButtonAction(sender: UIButton)
}

class PauseView: UIView {
    
    var controller: PauseViewController?
    var delegate: PauseViewButtonActionsDelegate?
    
    lazy var cardPause: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardSmall")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
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
        button.isEnabled = true
        button.setImage(UIImage(named: "buttonSmall"), for: .normal)
        button.addTarget(self, action: #selector(resumeButtonAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonSound: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.setImage(UIImage(named: "sound on"), for: .normal)
        button.addTarget(self, action: #selector(soundButtonAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func setUpCardPauseConstraints() {
        NSLayoutConstraint.activate([
            cardPause.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardPause.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardPause.widthAnchor.constraint(equalToConstant: 330 ),
            cardPause.heightAnchor.constraint(equalToConstant: 176 ),
        ])
    }
    
    func setUpButtonCloseConstraints() {
        NSLayoutConstraint.activate([
            buttonClose.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 16),
            buttonClose.leftAnchor.constraint(equalTo: cardPause.leftAnchor, constant: 24),
            buttonClose.widthAnchor.constraint(equalToConstant: 40),
            buttonClose.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setUpButtonSoundConstraints() {
        NSLayoutConstraint.activate([
            buttonSound.topAnchor.constraint(equalTo: cardPause.topAnchor, constant: 32),
            buttonSound.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonSound.widthAnchor.constraint(equalToConstant: 40),
            buttonSound.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpButtonMenuConstraints() {
        NSLayoutConstraint.activate([
            buttonMenu.topAnchor.constraint(equalTo: buttonSound.bottomAnchor, constant: 16),
            buttonMenu.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonMenu.widthAnchor.constraint(equalToConstant: 105),
            buttonMenu.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func setUpLabelMenuConstraints() {
        NSLayoutConstraint.activate([
            labelMenu.centerXAnchor.constraint(equalTo: buttonMenu.centerXAnchor),
            labelMenu.centerYAnchor.constraint(equalTo: buttonMenu.centerYAnchor),
        ])
    }
    
    func setUpLabelResumeConstraints() {
        NSLayoutConstraint.activate([
            labelResume.centerXAnchor.constraint(equalTo: buttonResume.centerXAnchor),
            labelResume.centerYAnchor.constraint(equalTo: buttonResume.centerYAnchor)
        ])
    }
    
    
    
    func setUpButtonResumeConstraints() {
        NSLayoutConstraint.activate([
            buttonResume.topAnchor.constraint(equalTo: buttonMenu.bottomAnchor, constant: 16),
            buttonResume.centerXAnchor.constraint(equalTo: cardPause.centerXAnchor),
            buttonResume.widthAnchor.constraint(equalToConstant: 105),
            buttonResume.heightAnchor.constraint(equalToConstant: 28)
        ])
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
