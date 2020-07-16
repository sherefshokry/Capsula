//
//  nationalitiesResponse.swift
//  Capsula
//
//  Created by SherifShokry on 7/1/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct NationalitiesResponse : Codable {
    var  nationalityList : [Nationality]?
    
    
   enum CodingKeys: String, CodingKey {
      case  nationalityList = "list"
    }
    
    init(){
     nationalityList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { nationalityList = try container.decodeIfPresent(.nationalityList) ?? [] }
        catch { nationalityList = [] }
    }
}
