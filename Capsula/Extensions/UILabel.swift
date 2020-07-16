//
//  UILabel.swift
//  mytoyota
//
//  Created by Nora on 5/15/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }  
    
    
    class func changeFontSize(){
        self.init().font = UIFont.systemFont(ofSize: 50)
    }
    
    public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            }else if fontNameToTest.range(of: "regular") != nil {
                fontName += "-Regular";
            }else if fontNameToTest.range(of: "italic") != nil {
                fontName += "-Italic";
            }
            else if fontNameToTest.range(of: "semibold") != nil {
                fontName += "-Semibold";
            }
            else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
    
  

  
}
