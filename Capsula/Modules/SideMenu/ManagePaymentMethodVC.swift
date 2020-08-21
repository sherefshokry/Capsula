//
//  ManagePaymentMethodVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import ContentSheet

class ManagePaymentMethodVC : UIViewController{
    
    @IBOutlet weak var topView : UIView!
    var applyPaymentMethod : ((Int) -> ())?
    var paymentType = -1
    @IBOutlet weak var visaSelectedIcon : UIImageView!
    @IBOutlet weak var madaSelectedIcon : UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if paymentType == 5 {
            maddaPressed(UIButton())
        }else if paymentType == 4 {
            visaPressed(UIButton())
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    
    
    @IBAction func maddaPressed(_ sender : UIButton){
        madaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        paymentType = 5
    }
    
    @IBAction func visaPressed(_ sender : UIButton){
        madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        paymentType = 4
    }
    
    
    @IBAction func applyPaymentMethodPressed(_ sender : UIButton){
        if self.applyPaymentMethod != nil {
            if paymentType == -1 {
                self.showMessage(Strings.paymentMethodSelection)
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

