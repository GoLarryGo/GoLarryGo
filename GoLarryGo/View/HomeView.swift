//
//  HomeView.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 17/03/21.
//
import UIKit

class HomeView: UIView {
    
    lazy var soundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "sound on"), for: .normal)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupViewHierarchy() {
        addSubview(soundButton)
        addSubview(logoImageView)
    }

    func setupConstraints() {
        setupSoundButton()
        setupLogoImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSoundButton() {
        NSLayoutConstraint.activate([
            soundButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            soundButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            soundButton.heightAnchor.constraint(equalToConstant: 44),
            soundButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupLogoImageView() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 378)
        ])
    }

}
