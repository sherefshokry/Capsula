//
//  UIView.swift
//  AHA! Journal
//
//  Created by George Naiem on 9/3/16.
//  Copyright © 2016 ahealthadventure. All rights reserved.
//

import UIKit

extension UIView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }


       @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var drobShadow: Bool {
        get{
            return false
        }
        set {
            self.dropShadow(apply: newValue)
            
        }
    }
   
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    func startRotating() {
        self.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations:
            { () -> Void in
                self.transform = self.transform.rotated(by: CGFloat(Double.pi/2))
        }) { (finished) -> Void in
            if self.tag == 10{
                self.startRotating()
            }else{
                self.isHidden = true
            }
        }
        tag = 10
    }

    
    
    func stopRotating() {
        
        tag = 0
        
    }
    
    func dropShadow(apply : Bool) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = apply ? UIColor.black.cgColor : UIColor.clear.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: -1, height: 0.5)
        self.layer.shadowRadius = 0.5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
   
       func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
              let topLeftRadius = CGSize(width: topLeft, height: topLeft)
              let topRightRadius = CGSize(width: topRight, height: topRight)
              let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
              let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
              let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
              
              let shape = CAShapeLayer()
              shape.path = maskPath.cgPath
              layer.mask = shape
          

          }
    
    func appIsArabic()->Bool{
        let language = Bundle.main.preferredLocalizations[0] as NSString
        if language.contains("ar"){
            return true
        }
        else{
            return false
        }
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, topPadding: CGFloat , bottomPadding: CGFloat, leftPadding:CGFloat , rightPadding: CGFloat , width: CGFloat , height: CGFloat)
     {
         translatesAutoresizingMaskIntoConstraints = false
         
         if let top = top
         {
             topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
         }
         
         if let bottom = bottom {
             bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
         }
         
         if let left = left {
             leadingAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
         }
         
         if let right = right {
             trailingAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
         }
         
         if width != 0 {
             widthAnchor.constraint(equalToConstant: width).isActive = true
         }
         if height != 0 {
             heightAnchor.constraint(equalToConstant: height).isActive = true
         }
         
         
     }
     
    
}
