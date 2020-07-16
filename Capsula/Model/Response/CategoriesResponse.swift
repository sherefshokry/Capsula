//
//  CategoriesResponse.swift
//  Capsula
//
//  Created by SherifShokry on 2/7/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import Foundation

struct  CategoriesResponse : Codable {
    var  categoriesList : [Category]?
    
   enum CodingKeys: String, CodingKey {
      case   categoriesList = "list"
    }
    
    init(){
      categoriesList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {  categoriesList = try container.decodeIfPresent(.categoriesList) ?? [] }
        catch {  categoriesList = [] }
    }
}
