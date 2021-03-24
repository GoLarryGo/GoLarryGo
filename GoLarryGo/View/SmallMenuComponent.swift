//
//  SmallMenuComponent.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit

class SmallMenuComponent: UIView {

    let gameOverTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PixelArial11", size: 30)
        label.text = "Game Over"
        label.textColor = UIColor(hue: 0, saturation: 3/100, brightness: 2/100, alpha: 1)
        return label
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PixelArial11", size: 17)
        label.textColor = UIColor(hue: 0, saturation: 3/100, brightness: 2/100, alpha: 1)
        return label
    }()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardSmall")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var buttonRestart: UIButton = buttonFactory(buttonTitle: "Restart")
    lazy var buttonMenu: UIButton = buttonFactory(buttonTitle: "Menu")

    lazy var imageViewButtonRestart = UIImageView(image: UIImage(named: "buttonSmall"))
    lazy var imageViewButtonMenu = UIImageView(image: UIImage(named: "buttonSmall"))

    func setupViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(gameOverTextLabel)
        addSubview(scoreLabel)
        addSubview(imageViewButtonRestart)
        addSubview(imageViewButtonMenu)
        addSubview(buttonRestart)
        addSubview(buttonMenu)
    }

    func setupConstraints() {
        setupBackgroundImageView()
        setupGameOverTextLabel()
        setupScoreLabel()
        setupImageViewButtons()
        setupButtonRestart()
        setupButtonMenu()
    }

    override func draw(_ rect: CGRect) {
        imageViewButtonMenu.isUserInteractionEnabled = true
        imageViewButtonRestart.isUserInteractionEnabled = true

        setupViewHierarchy()
        setupConstraints()
    }
}

extension SmallMenuComponent {

    func setupBackgroundImageView() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func setupGameOverTextLabel() {
        gameOverTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gameOverTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            gameOverTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupScoreLabel() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: gameOverTextLabel.bottomAnchor, constant: 12),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func setupImageViewButtons() {
        imageViewButtonRestart.translatesAutoresizingMaskIntoConstraints = false
        imageViewButtonMenu.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageViewButtonRestart.leftAnchor.constraint(equalTo: buttonRestart.leftAnchor),
            imageViewButtonRestart.bottomAnchor.constraint(equalTo: buttonRestart.bottomAnchor),
            imageViewButtonRestart.topAnchor.constraint(equalTo: buttonRestart.topAnchor),
            imageViewButtonRestart.rightAnchor.constraint(equalTo: buttonRestart.rightAnchor),

            imageViewButtonMenu.leftAnchor.constraint(equalTo: buttonMenu.leftAnchor),
            imageViewButtonMenu.bottomAnchor.constraint(equalTo: buttonMenu.bottomAnchor),
            imageViewButtonMenu.topAnchor.constraint(equalTo: buttonMenu.topAnchor),
            imageViewButtonMenu.rightAnchor.constraint(equalTo: buttonMenu.rightAnchor),
        ])
    }


    func setupButtonRestart() {
        buttonRestart.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonRestart.leftAnchor.constraint(equalTo: leftAnchor, constant: 42),
            buttonRestart.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonRestart.widthAnchor.constraint(equalToConstant: 105),
            buttonRestart.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    func setupButtonMenu() {
        buttonMenu.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonMenu.rightAnchor.constraint(equalTo: rightAnchor, constant: -42),
            buttonMenu.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonMenu.widthAnchor.constraint(equalToConstant: 105),
            buttonMenu.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}

extension SmallMenuComponent {
    func buttonFactory(buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear

        button.isEnabled = true
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PixelArial11", size: 13) as Any,
                                                          .foregroundColor: UIColor(hue: 44/360, saturation: 22/100, brightness: 99/100, alpha: 1)]
        button.setAttributedTitle(NSAttributedString(string: buttonTitle,
                                                     attributes: attributes),
                                                     for: .normal)
        return button
    }

}
