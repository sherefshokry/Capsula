//
//  HomeResponse.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct HomeResponse : Codable {
    var  categoriesData : [Category]?
    var  brandsData : [Brand]?
    var  storesData : [Store]?
    
   enum CodingKeys: String, CodingKey {
      case  categoriesData , brandsData , storesData
    }
    
    init(){
      categoriesData = []
      brandsData = []
      storesData = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { categoriesData = try container.decodeIfPresent(.categoriesData) ?? [] }
        catch { categoriesData = [] }
        do { brandsData = try container.decodeIfPresent(.brandsData) ?? [] }
        catch { brandsData = []}
        do { storesData = try container.decodeIfPresent(.storesData) ?? [] }
        catch { storesData = []}
    }
}
