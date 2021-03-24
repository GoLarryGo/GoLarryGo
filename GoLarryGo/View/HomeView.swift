//
//  HomeView.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 17/03/21.
//
import UIKit

protocol SoundButtonActionDelegate: class {
    func soundButtonTapped(sender: UIButton)
}

class HomeView: UIView {
    
    weak var delegate: SoundButtonActionDelegate?
    
    lazy var soundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        SoundButtonHelper.sharedSoundButtonState.setButtonImage(button: button)
        button.addTarget(self, action: #selector(soundButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoo")
        return imageView
    }()

    lazy var startLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "PixelArial11", size: 19)
        label.text = "Toque para iniciar"
        label.textColor = UIColor(red: 0.086, green: 0.612, blue: 0.569, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupViewHierarchy()
        setupConstraints()
        
    }
    
    func setupViewHierarchy() {
        addSubview(soundButton)
        addSubview(logoImageView)
        addSubview(startLabel)
    }

    func setupConstraints() {
        setupSoundButton()
        setupLogoImageView()
        setupStartLabel()
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
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            logoImageView.heightAnchor.constraint(equalToConstant: 142),
            logoImageView.widthAnchor.constraint(equalToConstant: 448)
        ])
    }

    func setupStartLabel() {
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            startLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc func soundButtonTapped(sender: UIButton) {
        delegate?.soundButtonTapped(sender: soundButton)
    }

}
