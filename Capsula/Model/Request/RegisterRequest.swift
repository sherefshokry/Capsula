//
//  RegisterRequest.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

public class RegisterRequest  : Codable {
    
    var name = ""
    var phone = ""
    var email = ""
    var password = ""
    var deviceToken = ""
    var image = ""


    init(){
    }    
    
    func getParams() -> [String : Any]{
        var params = [String : Any]()
        params["name"] = name
        params["phone"] = phone
        params["email"] = email
        params["password"] = password
         params["image"] = image
        
  //      params["device_token"] = deviceToken
  //      params["device_id"] = Utils.getDeviceID()
  //      params["device_type"] = 1
       return params
    }
}
