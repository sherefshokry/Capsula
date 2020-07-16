//
//  OrdersResponse.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  OrdersResponse : Codable {
    var  ordersList : [Order]?
    
    
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
