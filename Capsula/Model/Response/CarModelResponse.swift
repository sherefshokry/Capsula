//
//  CarModelResponse.swift
//  Capsula
//
//  Created by SherifShokry on 7/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct CarModelResponse : Codable {
    var  modelsList : [CarType]?
    
    
   enum CodingKeys: String, CodingKey {
      case  modelsList = "list"
    }
    
    init(){
     modelsList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { modelsList = try container.decodeIfPresent(.modelsList) ?? [] }
        catch { modelsList = [] }
    }
}
