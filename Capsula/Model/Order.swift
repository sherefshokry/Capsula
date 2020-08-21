//
//  Order.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct Order : Codable {
    
    let  id: Int?
     let orderCode : String?
    let  orderStatusId : Int?
    let  orderDate : String?
    let totalPrice : Double?
    let deliveryAddress : String?
    let prescriptionImageLink : String?
    let insuranceNumberImageLink : String?
    let paymentMethodId : Int?
    let itemsCost : Double?
    let vatCost : Double?
    let finalTotalCost : Double?
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case id ,orderCode , orderStatusId , orderDate ,totalPrice , deliveryAddress , prescriptionImageLink ,insuranceNumberImageLink,paymentMethodId,itemsCost,
        vatCost ,finalTotalCost
    }
    
    init(){
        id = -1
        orderCode = ""
        orderStatusId = -1
        orderDate = ""
        totalPrice = 0.0
        deliveryAddress = ""
        prescriptionImageLink = ""
        insuranceNumberImageLink = ""
        paymentMethodId = -1
        itemsCost = 0.0
        vatCost = 0.0
        finalTotalCost = 0.0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { id = try container.decodeIfPresent(.id) ?? -1 }
        catch { id = -1 }
        do {orderStatusId  = try container.decodeIfPresent(.orderStatusId) ?? -1 }
        catch { orderStatusId = -1 }
        do {   orderCode = try container.decodeIfPresent(.orderCode) ?? ""}
            catch {  orderCode = "" }
        do {   orderDate = try container.decodeIfPresent(.orderDate) ?? ""}
        catch {  orderDate = "" }
        do {totalPrice  = try container.decodeIfPresent(.totalPrice) ?? 0.0 }
        catch { totalPrice = 0.0 }
        do {   deliveryAddress = try container.decodeIfPresent(.deliveryAddress) ?? ""}
        catch {  deliveryAddress = "" }
        do {   prescriptionImageLink = try container.decodeIfPresent(.prescriptionImageLink) ?? ""}
        catch { prescriptionImageLink = "" }
        do {  insuranceNumberImageLink = try container.decodeIfPresent(.insuranceNumberImageLink) ?? ""}
        catch { insuranceNumberImageLink = "" }
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
