//
//  Store.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct Store : Codable {
    
    let  storeId: Int?
    let  storeName : String?
    let  imageLink : String?
 
    
    enum CodingKeys: String, CodingKey {
        case storeId, storeName , imageLink
    }
    
    init(){
     storeId = -1
     storeName = ""
     imageLink = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { storeId = try container.decodeIfPresent(.storeId) ?? -1 }
        catch { storeId = -1 }
        do {   storeName = try container.decodeIfPresent(.storeName) ?? ""}
        catch { storeName = "" }
        do {   imageLink = try container.decodeIfPresent(.imageLink) ?? ""}
              catch { imageLink = "" }
    }
}
