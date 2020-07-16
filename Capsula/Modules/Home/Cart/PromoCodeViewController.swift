//
//  PromoCodeViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/3/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import ContentSheet

class PromoCodeViewController : UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var promoField : CapsulaInputFeild!
    var applyPromoCodePressed : (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    
   override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           topView.clipsToBounds = true
           topView.layer.cornerRadius = 70
           topView.layer.maskedCorners = [.layerMaxXMinYCorner]
       }
    
    func setupInputFields(){
          promoField.type = .phoneNumber
          promoField.setTextFeildSpecs()
      }
    
    func validate() -> Bool {
           var isValid = true
           isValid = promoField.validate() && isValid
        
           return isValid
       }
       

    
    
  
    @IBAction func applyPromoCodePressed(_ sender : UIButton){
        
        if !validate(){
                    return
                }
        
        if self.applyPromoCodePressed != nil {
        self.dismiss(animated: true) {
          self.applyPromoCodePressed?()
        }
       }
    }
    
    
    override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 500
    }
    
    override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 300
    }
    
}
