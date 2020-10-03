//
//  Notification.swift
//  Capsula
//
//  Created by SherifShokry on 9/23/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct UserNotification : Codable {
    
    let  title: String?
    let  body : String?
    let  image : String?
    let  date : String?
    let  orderId : Int?
    let  product : Item?
    let type : Int?
    
    enum CodingKeys: String, CodingKey {
        case  title , body ,image , date , orderId , product, type
    }
    
    init(){
     title = ""
     body = ""
     image = ""
     date = ""
     orderId = -1
     type = -1
     product = Item()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { orderId = try container.decodeIfPresent(.orderId) ?? -1 }
        catch { orderId = -1 }
        do { type = try container.decodeIfPresent(.type) ?? -1 }
           catch { type = -1 }
        do {  title = try container.decodeIfPresent(.title) ?? ""}
        catch { title = "" }
        
        do {  image = try container.decodeIfPresent(.image) ?? ""}
        catch { image = "" }
        
        do {  body = try container.decodeIfPresent(.body) ?? ""}
        catch { body = "" }
        
        do {  date = try container.decodeIfPresent(.date) ?? ""}
        catch { date = "" }
        do {  product = try container.decodeIfPresent(.product) ?? Item()}
               catch { product = Item() }

    }
}
