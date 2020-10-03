//
//  Item.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation

struct Item : Codable, Equatable {
    
    var  productId: Int?
    var  mainId : Int?
    var  storeId : Int
    var  productName : String?
    var  productDesc : String?
    var  imagePath : String?
    var  price : Double?
    var  isTreatment : Bool?
    var  storeName : String?
    var  offerType : Int
    var  offerDesc : String?
    var  priceInOffer : Double?
    var  vat : Int?
    var  itemQuantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case productId , storeId, productName , productDesc , imagePath , isTreatment , mainId , price,storeName , offerType,offerDesc,priceInOffer,vat ,itemQuantity = "quantity"
    }
    
    init(){
        productId = -1
        storeId = -1
        mainId = -1
        productName = ""
        productDesc = ""
        imagePath = ""
        isTreatment = false
        price = 0.0
        storeName = ""
        offerType = -1
        offerDesc = ""
        priceInOffer = 0.0
        itemQuantity = 1
        vat = -1
    }
    
 
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { productId = try container.decodeIfPresent(.productId) ?? -1 }
        catch { productId = -1 }
        do { itemQuantity = try container.decodeIfPresent(.itemQuantity) ?? 1 }
              catch { itemQuantity = 1 }
        do { offerType = try container.decodeIfPresent(.offerType) ?? -1 }
             catch { offerType = -1 }
        do { storeId = try container.decodeIfPresent(.storeId) ?? -1 }
              catch { storeId = -1 }
        do { mainId = try container.decodeIfPresent(.mainId) ?? -1 }
        catch { mainId = -1 }
        do {   productName = try container.decodeIfPresent(.productName) ?? ""}
        catch { productName = "" }
        do {   productDesc = try container.decodeIfPresent(.productDesc) ?? ""}
              catch { productDesc = "" }
        do {   storeName = try container.decodeIfPresent(.storeName) ?? ""}
                    catch { storeName = "" }
        do {   imagePath = try container.decodeIfPresent(.imagePath) ?? ""}
        catch { imagePath = "" }
        do {  offerDesc = try container.decodeIfPresent(.offerDesc) ?? ""}
               catch { offerDesc = "" }
        do {   price = try container.decodeIfPresent(.price) ?? 0.0}
        catch { price = 0.0 }
        do { priceInOffer = try container.decodeIfPresent(.priceInOffer) ?? 0.0}
              catch { priceInOffer = 0.0 }
        do {  isTreatment = try container.decodeIfPresent(.isTreatment) ?? false}
               catch { isTreatment = false }
        do { vat = try container.decodeIfPresent(.vat) ?? -1 }
              catch { vat = -1 }
        
    }
}

