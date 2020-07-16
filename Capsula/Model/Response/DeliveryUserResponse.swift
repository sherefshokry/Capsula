//
//  DeliveryUserResponse.swift
//  Capsula
//
//  Created by SherifShokry on 7/11/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct DeliveryUserResponse : Codable {
    var  user : DeliveryUser?
    var  accessToken : String?
    
    enum CodingKeys: String, CodingKey {
        case user = "authUserData"
        case accessToken = "token"
    }
    
    init(){
      user = DeliveryUser()
      accessToken = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { user = try container.decodeIfPresent(.user) ?? DeliveryUser() }
        catch { user = DeliveryUser() }
        do { accessToken = try container.decodeIfPresent(.accessToken) ?? "" }
        catch { accessToken = "" }
    }
}
