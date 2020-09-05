//
//  SplashVC.swift
//  Capsula
//
//  Created by SherifShokry on 9/5/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit


class SplashVC : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Strings.shared = Strings()
        Strings.refreshAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkUser()
         }
       
    }
    
    
    func checkUser(){
        let isDeliveryMan = UserDefaults.standard.bool(forKey: "isDelivery")
             
             if isDeliveryMan {
                 
                 if (Utils.loadDeliveryUser()?.accessToken ?? "") == ""{
                      Utils.openWelcomeScreen()
                 }else{
                     Utils.openDeliveryHomeScreen()
                 }
               
             }else{
                 
                 if (Utils.loadUser()?.accessToken ?? "") == ""{
                     Utils.openWelcomeScreen()
                 }else{
                     Utils.openHomeScreen()
                 }
                 
             }
    
    }
    
    
    
    
}
