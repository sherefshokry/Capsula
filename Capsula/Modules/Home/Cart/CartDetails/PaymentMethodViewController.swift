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
    @IBOutlet weak var cashSelectedIcon : UIImageView!
    @IBOutlet weak var visaSelectedIcon : UIImageView!
    @IBOutlet weak var madaSelectedIcon : UIImageView!
    @IBOutlet weak var appleSelectedIcon : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if paymentType == 1 {
            cashPressed(UIButton())
        }else if paymentType == 5 {
            maddaPressed(UIButton())
        }else if paymentType == 4 {
            visaPressed(UIButton())
        }else if paymentType == 2 {
            applePressed(UIButton())
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    @IBAction func cashPressed(_ sender : UIButton){
        cashSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        appleSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        paymentType = 1
    }
    
    
    @IBAction func maddaPressed(_ sender : UIButton){
        cashSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        madaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
         appleSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        paymentType = 5
    }
    
    @IBAction func visaPressed(_ sender : UIButton){
        cashSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
          appleSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        paymentType = 4
    }
    
    @IBAction func applePressed(_ sender : UIButton){
             cashSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
             madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
             visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
             appleSelectedIcon.image = #imageLiteral(resourceName: "timeline")
             paymentType = 2
       }
    
    
    @IBAction func applyPaymentMethodPressed(_ sender : UIButton){
        if self.applyPaymentMethod != nil {
            if paymentType == -1 {
                self.showMessage(Strings.shared.paymentMethodSelection)
            }else{
                self.dismiss(animated: true) {
                    self.applyPaymentMethod?(self.paymentType)
                }
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

