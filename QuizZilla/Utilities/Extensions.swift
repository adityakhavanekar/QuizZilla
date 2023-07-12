//
//  Extensions.swift
//  QuizZilla
//
//  Created by APPLE on 09/05/23.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255
                    a = 1
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIButton {
    func applyLiftedShadowEffect(cornerRadius:CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }
}

extension UIView {
    
    func applyLiftedShadowEffectToView(cornerRadius:CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }
    
    enum ViewSide {
            case left, right, top, bottom
        }
        
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .left: border.frame = CGRect(x: 0.0, y: 0.0, width: thickness, height: frame.height); break
        case .right: border.frame = CGRect(x: frame.width-thickness, y: 0.0, width: thickness, height: frame.height); break
        case .top: border.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: thickness); break
        case .bottom: border.frame = CGRect(x: 0.0, y: frame.height-thickness, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
}
