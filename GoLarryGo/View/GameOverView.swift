//
//  GameOverView.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit

class GameOverView: UIView {
    let gameOverTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PixelArial11", size: 40)
        label.text = "Game Over"
        label.textColor = UIColor.white
        return label
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PixelArial11Bold", size: 17)
        label.textColor = UIColor.white
        label.text = "Score 500"
        return label
    }()

    let smallCard = SmallMenuComponent()

    func setupViewHierarchy() {
        addSubview(gameOverTextLabel)
        addSubview(scoreLabel)
        addSubview(smallCard)
    }

    func setupConstraints() {
        setupGameOverTextLabel()
        setupScoreLabel()
        setupSmallCard()
    }
    override func draw(_ rect: CGRect) {
        setupViewHierarchy()
        setupConstraints()
        smallCard.draw(CGRect())
    }
}

extension GameOverView {
    func setupGameOverTextLabel() {
        gameOverTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gameOverTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            gameOverTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupScoreLabel() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: gameOverTextLabel.bottomAnchor, constant: 17),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupSmallCard() {
        smallCard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            smallCard.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 31),
            smallCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            smallCard.heightAnchor.constraint(equalToConstant: 144),
            smallCard.widthAnchor.constraint(equalToConstant: 270)
        ])
    }
}
