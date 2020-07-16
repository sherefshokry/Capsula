//
//  ItemsResponse.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  ItemsResponse : Codable {
    var  itemsList : [Item]?
    
    
   enum CodingKeys: String, CodingKey {
      case   itemsList = "list"
    }
    
    init(){
     itemsList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {  itemsList = try container.decodeIfPresent(.itemsList) ?? [] }
        catch {  itemsList = [] }
    }
}
