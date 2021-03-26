//
//  GameOverView.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit

protocol GameOverViewDelegate: class {
    func presentMenuViewController()
}

class GameOverView: UIView {
    let smallCard = SmallMenuComponent()
    weak var delegate: GameOverViewDelegate?

    func setupViewHierarchy() {
        addSubview(smallCard)
    }

    func setupConstraints() {
        setupSmallCard()
    }

    override func draw(_ rect: CGRect) {
        setupViewHierarchy()
        setupConstraints()
        smallCard.draw(CGRect())
    }

}

extension GameOverView {

    func setupSmallCard() {
        smallCard.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            smallCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            smallCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            smallCard.heightAnchor.constraint(equalToConstant: 176),
            smallCard.widthAnchor.constraint(equalToConstant: 330)
        ])
    }
}
