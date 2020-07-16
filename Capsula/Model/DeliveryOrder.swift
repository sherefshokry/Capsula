//
//  DeliveryOrder.swift
//  Capsula
//
//  Created by SherifShokry on 7/11/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct DeliveryOrder : Codable {
    
    let  id: Int?
    let orderCode : String?
    let customerName : String?
    let customerAddress : String?
    let customerLat : Double?
    let customerLong  : Double?
    let storeAddress : String?
    let storeLat : Double?
    let storeLong : Double?
    let totalPrice : Double?
    let paymentMethodId : Int?
    let itemsCost : Double?
    let vatCost : Double?
    let finalTotalCost : Double?
    let phoneNumber : String?
    let statusId : Int?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "orderId" , orderCode,customerName,customerAddress  , customerLat , customerLong ,storeAddress , storeLat , storeLong ,totalPrice ,paymentMethodId,itemsCost,
        vatCost ,finalTotalCost, phoneNumber , statusId
    }
    
    init(){
        id = -1
        orderCode = ""
        customerName = ""
        customerAddress = ""
        customerLat = 0.0
        customerLong = 0.0
        storeAddress = ""
        storeLat = 0.0
        storeLong = 0.0
        totalPrice = 0.0
        paymentMethodId = -1
        itemsCost = 0.0
        vatCost = 0.0
        finalTotalCost = 0.0
        phoneNumber = ""
        statusId = -1
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        
        do { statusId = try container.decodeIfPresent(.statusId) ?? -1 }
        catch {statusId = -1 }
        
        do {  orderCode = try container.decodeIfPresent(.orderCode) ?? ""}
               catch {  orderCode = "" }
        
        do {  customerName = try container.decodeIfPresent(.customerName) ?? ""}
                      catch {  customerName = "" }
        
        do {  customerAddress = try container.decodeIfPresent(.customerAddress) ?? ""}
                      catch {   customerAddress = "" }
        
        do {  phoneNumber = try container.decodeIfPresent(.phoneNumber) ?? ""}
                      catch {   phoneNumber = "" }
        
        do {  customerLat = try container.decodeIfPresent(.customerLat) ?? 0.0}
        catch {  customerLat = 0.0 }
        
        
        do {  customerLong = try container.decodeIfPresent(.customerLong) ?? 0.0}
        catch {  customerLong = 0.0 }
        
        
        do {  storeAddress = try container.decodeIfPresent(.storeAddress) ?? ""}
                      catch {  storeAddress = "" }
        
        do { storeLat = try container.decodeIfPresent(.storeLat) ?? 0.0}
        catch {  storeLat = 0.0 }
        do { storeLong = try container.decodeIfPresent(.storeLong) ?? 0.0}
              catch {   storeLong = 0.0 }
     
        do {totalPrice  = try container.decodeIfPresent(.totalPrice) ?? 0.0 }
        catch { totalPrice = 0.0 }
        do {paymentMethodId = try container.decodeIfPresent(.paymentMethodId) ?? -1 }
        catch { paymentMethodId = -1 }
        do {itemsCost  = try container.decodeIfPresent(.itemsCost) ?? 0.0 }
        catch { itemsCost = 0.0 }
        do {vatCost  = try container.decodeIfPresent(.vatCost) ?? 0.0 }
        catch { vatCost = 0.0 }
        do {finalTotalCost  = try container.decodeIfPresent(.finalTotalCost) ?? 0.0 }
        catch { finalTotalCost = 0.0 }
        
        
        
    }
}
