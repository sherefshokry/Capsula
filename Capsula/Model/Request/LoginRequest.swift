//
//  LoginRequest.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

public class LoginRequest  : Codable {
    
    var phoneOrEmail = ""
    var password = ""
    var deviceToken = ""

    
    init(){
    }
 
    func getParams() -> [String : Any]{
        var params = [String : Any]()
        params["phoneOrMail"] = phoneOrEmail
        params["password"] = password
     //   params["device_token"] = Utils.getFCMToken()
      //  params["device_id"] = Utils.getDeviceID()
      //  params["device_type"] = 1
        
        return params
    }
}
