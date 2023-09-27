//
//  CardViewCell.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 25/09/2023.
//

import UIKit

//for Fram around Cells
class CardViewCell: UIView {
    @IBInspectable var cornerRadius: CGFloat = 25
    @IBInspectable var shadowOffsetWidth: CGFloat = 25
    @IBInspectable var shadowOffsetHeight: CGFloat = 25
    @IBInspectable var shadowOpacity: CGFloat = 0.0
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var boarderWidth: CGFloat = 0.8
    @IBInspectable var boarderColor: UIColor?
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowColor = shadowColor.cgColor
        layer.borderWidth = boarderWidth
        layer.borderColor = boarderColor?.cgColor
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        
    }
}

