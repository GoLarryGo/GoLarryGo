//
//  ScoreView.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 18/03/21.
//

import UIKit

class ScoreView: UIView {
    
    lazy var labelScore: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "PixelArial11", size: 17)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    var timer: Timer?
    static var startGame:Bool = false
    
    var score: Int = 0 {
        didSet {
            labelScore.text = "Score: \(score)"
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        self.addSubview(labelScore)
        
            if self.timer == nil {
              let timer = Timer(timeInterval: 1.0,
                                target: self,
                                selector: #selector(self.updateTimer),
                                userInfo: nil,
                                repeats: true)
              RunLoop.current.add(timer, forMode: .common)
              self.timer = timer
            }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateTimer() {
        if let timer = timer {
            if ScoreView.startGame == false {
                score = 0
            } else {
                score += Int(timer.timeInterval)
            }
            print(score)
        }
    }

}
