//
//  CheckoutRequest.swift
//  Capsula
//
//  Created by SherifShokry on 4/20/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

public class CheckoutRequest  : Codable {
    
    var paymentMethod = 1
    var prescriptionImage = ""
    var insuranceNumberImage = ""
    var resourcePath = ""
    
    init(){
    }
 
    func getParams() -> [String : Any]{
        var params = [String : Any]()
        params["paymentMethodType"] = paymentMethod
        params["prescriptionImage"] = prescriptionImage
        params["insuranceNumberImage"] = insuranceNumberImage
        params["resourcePath"] = resourcePath
        return params
        
    }
}
