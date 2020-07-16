//
//  Address.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation

struct Address : Codable , Equatable {
    let  id: Int?
    let  latitude : Double?
    let  longitude : Double?
    let  addressDesc : String?
    var  isSelected = false
 
    
    enum CodingKeys: String, CodingKey {
        case id = "addressId" , latitude , longitude , addressDesc
    }
    
    init(){
        id = -1
        latitude = 0.0
        longitude = 0.0
        addressDesc = ""
     
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        do {   latitude = try container.decodeIfPresent(.latitude) ?? 0.0}
        catch { latitude = 0.0 }
        do {   longitude = try container.decodeIfPresent(.longitude) ?? 0.0}
              catch { longitude = 0.0 }
        do {  addressDesc = try container.decodeIfPresent(.addressDesc) ?? ""}
        catch { addressDesc = "" }
      
    }
}
