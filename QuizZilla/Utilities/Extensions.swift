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

extension UIButton {
    func applyLiftedShadowEffectToButton(cornerRadius:CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }
}

extension UIView {
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
    func applyLiftedShadowEffectToView(cornerRadius:CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
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
    
    func animateView(correct:Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if correct == true{
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }else{
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
    
    func seaSawView(hexString:String) {
        let duration = 0.2
        let angle: CGFloat = .pi / 8
        
        self.backgroundColor = UIColor(hex: hexString)
        
        let seaSawAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        seaSawAnimation.duration = duration
        seaSawAnimation.values = [0, angle, 0, -angle, 0]
        seaSawAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        seaSawAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        self.layer.add(seaSawAnimation, forKey: "seaSawAnimation")
    }
}


extension UIImageView {
    func applyBlurEffect() {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        guard let img = self.image else {return}
        guard let beginImage = CIImage(image: img) else {return}
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(5, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        self.image = processedImage
    }
}

extension UICollectionView{
    func animateCollection() {
        self.isUserInteractionEnabled = false
        let cells = self.visibleCells
        let collectionViewWidth = self.bounds.size.width
        
        for (index, cell) in cells.enumerated() {
            let translationX = index % 2 == 0 ? -collectionViewWidth : collectionViewWidth
            cell.transform = CGAffineTransform(translationX: translationX, y: 0)
            cell.alpha = 0
        }
        
        var delayCounter = 0.05
        for (_, cell) in cells.enumerated() {
            UIView.animate(withDuration: 0.3, delay: delayCounter, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                cell.alpha = 1
            }, completion: nil)
            
            delayCounter += 0.05
        }
        self.isUserInteractionEnabled = true
    }
}
