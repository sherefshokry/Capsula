//
//  CartCongratViewController.swift
//  Capsula
//
//  Created by SherifShokry on 3/30/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Intercom


class CartCongratViewController : UIViewController{
    
    @IBOutlet weak var trackOrderBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackOrderBtn.setUnderLineText(text: Strings.shared.trackOrder)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if Utils.loadUser()?.accessToken ?? "" != "" {
               Intercom.setLauncherVisible(true)
            }
        }
    
    
    @IBAction func trackOrderPressed(_ sender : UIButton){
        
      let vc = OrderListViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
      self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
}
