//
//  DeliveryOrdersResponse.swift
//  Capsula
//
//  Created by SherifShokry on 7/11/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  DeliveryOrdersResponse : Codable {
    var  ordersList : [DeliveryOrder]?
    
    
   enum CodingKeys: String, CodingKey {
      case  ordersList = "list"
    }
    
    init(){
     ordersList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { ordersList = try container.decodeIfPresent(.ordersList) ?? [] }
        catch { ordersList = [] }
    }
}
