//
//  SmallMenuComponent.swift
//  GoLarryGo
//
//  Created by Lucas Oliveira on 22/03/21.
//

import UIKit

class SmallMenuComponent: UIView {

    let nicknameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PixelArial11", size: 17)
        label.textColor = UIColor(hue: 0, saturation: 3/100, brightness: 2/100, alpha: 1)
        label.text = "Nickname"
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "TextField"
        textField.backgroundColor = .white
        textField.textColor = UIColor(hue: 0, saturation: 3/100, brightness: 2/100, alpha: 1)
        return textField
    }()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardSmall")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var buttonSave: UIButton = buttonFactory(buttonTitle: "Salvar")
    lazy var buttonCancel: UIButton = buttonFactory(buttonTitle: "Cancelar")

    lazy var imageViewSaveButton = UIImageView(image: UIImage(named: "buttonSmall"))
    lazy var imageViewCancelButton = UIImageView(image: UIImage(named: "buttonSmall"))

    func setupViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(nicknameTextLabel)
        addSubview(textField)
        addSubview(imageViewSaveButton)
        addSubview(imageViewCancelButton)
        addSubview(buttonSave)
        addSubview(buttonCancel)
    }

    func setupConstraints() {
        setupBackgroundImageView()
        setupNicknameTextLabel()
        setupTextField()
        setupImageViewButtons()
        setupButtonSave()
        setupButtonCancel()
    }

    override func draw(_ rect: CGRect) {
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

    func setupNicknameTextLabel() {
        nicknameTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nicknameTextLabel.topAnchor.constraint(equalTo: topAnchor,constant: 13),
            nicknameTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: nicknameTextLabel.bottomAnchor, constant: 17),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 169),
            textField.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    func setupImageViewButtons() {
        imageViewSaveButton.translatesAutoresizingMaskIntoConstraints = false
        imageViewCancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageViewSaveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            imageViewSaveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            imageViewSaveButton.widthAnchor.constraint(equalToConstant: 105),
            imageViewSaveButton.heightAnchor.constraint(equalToConstant: 28),

            imageViewCancelButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            imageViewCancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            imageViewCancelButton.widthAnchor.constraint(equalToConstant: 105),
            imageViewCancelButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }


    func setupButtonSave() {
        buttonSave.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonSave.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            buttonSave.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            buttonSave.widthAnchor.constraint(equalToConstant: 105),
            buttonSave.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    func setupButtonCancel() {
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonCancel.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            buttonCancel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            buttonCancel.widthAnchor.constraint(equalToConstant: 105),
            buttonCancel.heightAnchor.constraint(equalToConstant: 28)
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
        button.setTitle("Slava", for: .normal)
        return button
    }

}
