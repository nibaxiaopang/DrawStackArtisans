//
//  GradientView.swift
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/31.
//

import UIKit

@IBDesignable
class DrawGradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable var angle: CGFloat = 0.0 {
        didSet {
            updateGradient()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private func updateGradient() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        
        let angleInRadians = angle * .pi / 180.0
        let startPointX = 0.5 + cos(angleInRadians) * 0.5
        let startPointY = 0.5 + sin(angleInRadians) * 0.5
        let endPointX = 1.0 - startPointX
        let endPointY = 1.0 - startPointY
        
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
