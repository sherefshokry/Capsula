//
//  AboutUsVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class AboutUsVC : UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var aboutImage : UIImageView!
    @IBOutlet weak var aboutDescription : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
             super.viewWillLayoutSubviews()
             topView.clipsToBounds = true
             topView.layer.cornerRadius = 70
             topView.layer.maskedCorners = [.layerMinXMaxYCorner]
         }
      
    
    
    
}
