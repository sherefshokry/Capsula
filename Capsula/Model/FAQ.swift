//
//  FAQ.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct FAQ : Codable {
    
    let  id: Int?
    var  name: String?
    var  description: String?
    var  isExpanded = false
    
    enum CodingKeys: String, CodingKey {
        case id , name , description
    }
    
    init(){
        id = -1
        name = ""
        description = ""
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        do {   name = try container.decodeIfPresent(.name) ?? ""}
        catch { name = "" }
        do {   description = try container.decodeIfPresent(.description) ?? ""}
        catch { description  = "" }
    }
}
