//
//  SideMenuItem.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class SideMenu : NSObject {
    var elementText = ""
    var elementIcon = UIImage()
   
    
    init(elementText: String, elementIcon : UIImage) {
        super.init()
        self.elementText = elementText
        self.elementIcon = elementIcon
    }

}
