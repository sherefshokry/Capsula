//
//  UIImageView.swift
//  Capsula
//
//  Created by SherifShokry on 9/8/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
         if ((self.image ?? UIImage()).isEqualToImage(#imageLiteral(resourceName: "icRightArrow"))) {
                      
                      if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
                          self.image = #imageLiteral(resourceName: "icBackBlue")
                      }
                  }
        
    }
    
}
