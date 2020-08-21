//
//  UserProfileViewController.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import Intercom
class UserProfileViewController : UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var userEmailLabel : UILabel!
    @IBOutlet weak var userPhoneLabel : UILabel!
    @IBOutlet weak var userDefaultAddress : UILabel!
    @IBOutlet weak var userImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let user =  Utils.loadUser()?.user ?? User()
        userNameLabel.text = user.name ?? ""
        userEmailLabel.text = user.email ?? ""
        userPhoneLabel.text = "+96" + (user.phone ?? "")
        userDefaultAddress.text = user.defaultAddress?.addressDesc ?? ""
        userImage.sd_setImage(with: URL.init(string: user.photo ?? ""), placeholderImage: nil)

    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
         topView.clipsToBounds = true
         topView.layer.cornerRadius = 70
         topView.layer.maskedCorners = [.layerMinXMaxYCorner]
     }
     
     
//     override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         Intercom.setLauncherVisible(false)
//     }
     
    
    
    
    @IBAction func editUserProfile(_ sender : UIButton){
    
        
        
        
    }
    
    
}
