//
//  PaymentMethodViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/18/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import ContentSheet

class PaymentMethodViewController : UIViewController{
    
      @IBOutlet weak var topView : UIView!
      var applyPaymentMethod : ((Int) -> ())?
      var paymentType = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           topView.clipsToBounds = true
           topView.layer.cornerRadius = 70
           topView.layer.maskedCorners = [.layerMaxXMinYCorner]
       }
    
    
@IBAction func applyPaymentMethodPressed(_ sender : UIButton){
     if self.applyPaymentMethod != nil {
     self.dismiss(animated: true) {
       self.applyPaymentMethod?(self.paymentType)
     }
    }
    }
    
   
      override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
          return 900
      }
      
      override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
          return 600
      }
    
 }

