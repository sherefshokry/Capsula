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
        setUserData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUserData(_:)),
                                               name: NSNotification.Name(rawValue: Constants.REFRESH_USER_DATA), object: nil)
    }
    
    @objc func refreshUserData(_ notification: NSNotification){
        setUserData()
    }
    
    
    func setUserData(){
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

    
    
    
    
    @IBAction func editUserProfile(_ sender : UIButton){
        
        let vc = EditUserProfileVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}
