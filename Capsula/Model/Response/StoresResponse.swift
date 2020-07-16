//
//  StoresResponse.swift
//  Capsula
//
//  Created by SherifShokry on 2/7/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  StoresResponse : Codable {
    var  storesList : [Store]?
    
    
   enum CodingKeys: String, CodingKey {
      case  storesList = "list"
    }
    
    init(){
     storesList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { storesList = try container.decodeIfPresent(.storesList) ?? [] }
        catch { storesList = [] }
    }
}
