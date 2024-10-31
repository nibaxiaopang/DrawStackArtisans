//
//  InnerShadowView.swift
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/31.
//

import UIKit

@IBDesignable
class DrawInnerShadowView: UIView {
    
    @IBInspectable var innerShadowColor: UIColor = UIColor.black {
        didSet { setupInnerShadow() }
    }
    
    @IBInspectable var innerShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet { setupInnerShadow() }
    }
    
    @IBInspectable var innerShadowOpacity: Float = 0.5 {
        didSet { setupInnerShadow() }
    }
    
    @IBInspectable var innerShadowRadius: CGFloat = 10 {
        didSet { setupInnerShadow() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnerShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInnerShadow()
    }
    
    private func setupInnerShadow() {
        // Remove existing shadow layers to prevent duplicate shadows
        layer.sublayers?.filter { $0.name == "innerShadowLayer" }.forEach { $0.removeFromSuperlayer() }
        
        // Create a shadow layer
        let shadowLayer = CALayer()
        shadowLayer.name = "innerShadowLayer"
        shadowLayer.frame = bounds
        shadowLayer.backgroundColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = innerShadowColor.cgColor
        shadowLayer.shadowOffset = innerShadowOffset
        shadowLayer.shadowOpacity = innerShadowOpacity
        shadowLayer.shadowRadius = innerShadowRadius
        shadowLayer.cornerRadius = layer.cornerRadius
        
        // Create a path that is slightly inset from the view's bounds
        let path = UIBezierPath(rect: bounds.insetBy(dx: -innerShadowRadius, dy: -innerShadowRadius))
        let cutout = UIBezierPath(rect: bounds).reversing()
        path.append(cutout)
        shadowLayer.shadowPath = path.cgPath
        
        // Add the shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        // Optionally, set masksToBounds to true if the shadow should respect the view's bounds
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupInnerShadow()
    }
}
