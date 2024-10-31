//
//  CircularGradientView.swift
//  DrawStackArtisans
//
//  Created by jin fu on 2024/10/31.
//

import UIKit

@IBDesignable
class DrawCircularGradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var endColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = calculateRadiusForGradient(rect: rect)
        
        context.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: [])
    }
    
    private func calculateRadiusForGradient(rect: CGRect) -> CGFloat {
        let width = rect.width
        let height = rect.height
        return sqrt((width * width) + (height * height)) / 2
    }
}
