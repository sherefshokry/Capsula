//
//  NotificationResponse.swift
//  Capsula
//
//  Created by SherifShokry on 9/23/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  NotificationResponse : Codable {
    var  notificationsList : [UserNotification]?
    
    
   enum CodingKeys: String, CodingKey {
      case  notificationsList  = "list"
    }
    
    init(){
     notificationsList  = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { notificationsList  = try container.decodeIfPresent(.notificationsList) ?? [] }
        catch { notificationsList  = [] }
    }
}
