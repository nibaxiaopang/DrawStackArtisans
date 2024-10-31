//
//  PopUpWindow.swift
//  DrawStackArtisans
//
//  Created by jin fu on 2024/10/31.
//

import UIKit

protocol DrawPopUpDelegate {
    func handleDismissal()
}

class DrawPopUpWindow: UIView {

    // MARK: - Properties
    
    var delegate: DrawPopUpDelegate?
    
    var showScore: Int? {
        didSet {
            guard let score = showScore else { return }
            iconLabel.text = "🎯"
            messageLabel.text = "Your score: \(score)"
        }
    }
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 96)
        
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("End Game", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(iconLabel)
        iconLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -28).isActive = true
        iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 0).isActive = true
        
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
}
