//
//  BaseResponse.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation

class BaseResponse<T : Codable> : Codable {
 
    var data : T?
    
    
}

