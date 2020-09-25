//
//  UpdateUserResponse.swift
//  Capsula
//
//  Created by SherifShokry on 9/23/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation

struct UpdateUserResponse : Codable {
    var  user : User?
    
    enum CodingKeys: String, CodingKey {
        case user = "data"
    }
    
    init(){
      user = User()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { user = try container.decodeIfPresent(.user) ?? User() }
        catch { user = User() }
    }
}
