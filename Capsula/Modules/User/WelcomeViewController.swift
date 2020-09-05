//
//  WelcomeViewController.swift
//  Capsula
//
//  Created by SherifShokry on 6/5/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Intercom

class WelcomeViewController : UIViewController {
     
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var deliveryView : UIView!
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var deliveryImage: UIImageView!
    @IBOutlet weak var customerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    override func viewWillLayoutSubviews() {
               super.viewWillLayoutSubviews()
               containerView.clipsToBounds = true
               containerView.layer.cornerRadius = 70
               containerView.layer.maskedCorners = [.layerMaxXMinYCorner]
     }
    
    
    
    @IBAction func deliveryManPressed(_ sender : UIButton){
        deliveryView.borderWidth = 2
        customerView.borderWidth = 0
        deliveryImage.tintColor = UIColor.init(codeString: "#0E518A")
        customerImage.tintColor = UIColor.init(codeString: "#CFD1D2")
         UserDefaults.standard.set(true, forKey: "isDelivery")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Utils.openLoginScreen(isDeliveryMan : true)
        }
        
    }
    
    
    @IBAction func customerPressed(_ sender : UIButton){
           deliveryView.borderWidth = 0
           customerView.borderWidth = 2
           deliveryImage.tintColor = UIColor.init(codeString: "#CFD1D2")
           customerImage.tintColor = UIColor.init(codeString: "#0E518A")
         UserDefaults.standard.set(false, forKey: "isDelivery")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Utils.openLoginScreen(isDeliveryMan : false)
        }
    }
    
}
