//
//  NSMutableAttributedString.swift
//  MyLexus
//
//  Created by Nora on 7/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    @discardableResult func customWithFont(_ text: String , font : UIFont , color  : UIColor? = nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.font: font]
        if color != nil{
            attrs[.foregroundColor] = color
        }
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
  
 
}
