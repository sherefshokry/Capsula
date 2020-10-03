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
    let  distance : Double?
 
    
    enum CodingKeys: String, CodingKey {
        case storeId, storeName , imageLink , distance
    }
    
    init(){
     storeId = -1
     storeName = ""
     imageLink = ""
     distance = 0.0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { storeId = try container.decodeIfPresent(.storeId) ?? -1 }
        catch { storeId = -1 }
        do {   storeName = try container.decodeIfPresent(.storeName) ?? ""}
        catch { storeName = "" }
        do {   imageLink = try container.decodeIfPresent(.imageLink) ?? ""}
              catch { imageLink = "" }
        do { distance = try container.decodeIfPresent(.distance) ?? 0.0}
        catch { distance = 0.0}
    }
}
