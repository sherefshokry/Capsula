//
//  BrandsResponse.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  BrandsResponse : Codable {
    var  brandsList : [Brand]?
    
    
   enum CodingKeys: String, CodingKey {
      case   brandsList = "list"
    }
    
    init(){
     brandsList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {  brandsList = try container.decodeIfPresent(.brandsList) ?? [] }
        catch {  brandsList = [] }
    }
}
