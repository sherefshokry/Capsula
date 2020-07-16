//
//  UserResponse.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation

struct UserResponse : Codable {
    var  user : User?
    var  accessToken : String?
    
    enum CodingKeys: String, CodingKey {
        case user = "authUserData"
        case accessToken = "token"
    }
    
    init(){
      user = User()
      accessToken = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { user = try container.decodeIfPresent(.user) ?? User() }
        catch { user = User() }
        do { accessToken = try container.decodeIfPresent(.accessToken) ?? "" }
        catch { accessToken = "" }
    }
}
