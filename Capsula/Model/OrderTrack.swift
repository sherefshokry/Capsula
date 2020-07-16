//
//  Track.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct OrderTrack : Codable {
    
    let  orderStatusId: Int?
    let  orderStatusDesc : String?
    let  operationDate : String?
 
    
    enum CodingKeys: String, CodingKey {
        case  orderStatusDesc, operationDate ,orderStatusId
    }
    
    init(){
     orderStatusId = -1
     orderStatusDesc = ""
     operationDate = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { orderStatusId = try container.decodeIfPresent(.orderStatusId) ?? -1 }
        catch { orderStatusId = -1 }
        do {   orderStatusDesc = try container.decodeIfPresent(.orderStatusDesc) ?? ""}
        catch { orderStatusDesc = "" }

        do {  operationDate = try container.decodeIfPresent(.operationDate) ?? ""}
              catch {operationDate = "" }
    }
}
