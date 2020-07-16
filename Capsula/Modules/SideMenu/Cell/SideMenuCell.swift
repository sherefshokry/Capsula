//
//  SideMenuCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit


class SideMenuCell : UITableViewCell{
    
    
    @IBOutlet weak var sideMenuImage : UIImageView!
    @IBOutlet weak var sideMenuTitle : UILabel!
    
    func setData(sideMenuItem : SideMenu){
        
        sideMenuImage.image = sideMenuItem.elementIcon
        sideMenuTitle.text = sideMenuItem.elementText
        
    }
    
    
    
}
