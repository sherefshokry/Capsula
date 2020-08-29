//
//  User.swift
//  Capsula
//
//  Created by SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//
import Foundation

struct User : Codable {
    let  id: Int?
    let  name : String?
    let  phone : String?
    let  email : String?
    let  photo : String?
    var  defaultAddress : Address?
    let  addressList : [Address]?
    var  cartContent : [Item]?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "userId" , name , phone , photo = "imagePath" , email, cartContent
        case addressList = "userAddresses" , defaultAddress =  "defaultAddress"
    }
    
    init(){
        id = -1
        name = ""
        phone = ""
        email = ""
        photo = ""
        defaultAddress = Address()
        addressList = []
        cartContent = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        do {   name = try container.decodeIfPresent(.name) ?? ""}
        catch { name = "" }
        do {  phone = try container.decodeIfPresent(.phone) ?? ""}
        catch { phone = "" }
        do {  photo = try container.decodeIfPresent(.photo) ?? ""}
        catch { photo = "" }
        do {  email  = try container.decodeIfPresent(.email) ?? ""}
        catch { email = "" }
        do {  defaultAddress  = try container.decodeIfPresent(.defaultAddress) ?? Address() }
               catch { defaultAddress = Address() }
        do {  addressList  = try container.decodeIfPresent(.addressList) ?? [] }
             catch { addressList = [] }
        do {  cartContent = try container.decodeIfPresent(.cartContent) ?? [] }
                    catch { cartContent  = [] }
    }
    
}
