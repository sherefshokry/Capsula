//
//  CarType.swift
//  Capsula
//
//  Created by SherifShokry on 7/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct CarType : Codable {
    
    let  id: Int?
    let  value : String?
  
    
    enum CodingKeys: String, CodingKey {
        case  id, value
    }
    
    init(){
     id = -1
     value = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        do {  value = try container.decodeIfPresent(.value) ?? ""}
        catch { value = "" }

    }
}
