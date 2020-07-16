//
//  OrderTrackingResponse.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  OrderTrackingResponse : Codable {
    var  orderList : [OrderTrack]?
    
    
   enum CodingKeys: String, CodingKey {
      case  orderList = "list"
    }
    
    init(){
     orderList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { orderList = try container.decodeIfPresent(.orderList) ?? [] }
        catch { orderList = [] }
    }
}
