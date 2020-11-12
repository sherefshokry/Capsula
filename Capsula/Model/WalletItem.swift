//
//  WalletItem.swift
//  Capsula
//
//  Created by SherifShokry on 8/22/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  WalletItem : Codable {
    
    
    let  countOfCompletedOrders : Int?
    let totalDeliveryCostCashOrder : Double?
    let totalDeliveryCostOnlineOrder : Double?
    let totalDeliveryCost : Double?
    let discount : Double?
   // let totalCreditCustomerOrderAmountCash : Double?
    let bonuses : Double?
    let compensations : Double?
    let balance : Double?
    let payments : Double?
    let collection : Double?
    let endingBalance  : Double?
    
    enum CodingKeys: String, CodingKey {
        case countOfCompletedOrders
        ,totalDeliveryCostCashOrder
        ,totalDeliveryCostOnlineOrder
        
        case totalDeliveryCost,discount,bonuses, compensations
        //totalCreditCustomerOrderAmountCash
        
        
        case balance,payments,collection,endingBalance
    }
    
    init(){
        countOfCompletedOrders = 0
        totalDeliveryCostCashOrder = 0.0
        totalDeliveryCostOnlineOrder = 0.0
        totalDeliveryCost = 0.0
        discount = 0.0
        //totalCreditCustomerOrderAmountCash = 0.0
        bonuses = 0.0
        compensations = 0.0
        balance = 0.0
        payments = 0.0
        collection  = 0.0
        endingBalance = 0.0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { countOfCompletedOrders = try container.decodeIfPresent(.countOfCompletedOrders) ?? 0 }
        catch { countOfCompletedOrders = 0 }
        do { totalDeliveryCostCashOrder = try container.decodeIfPresent(.totalDeliveryCostCashOrder) ?? 0.0 }
        catch { totalDeliveryCostCashOrder = 0.0 }
        
        do { totalDeliveryCostOnlineOrder = try container.decodeIfPresent(.totalDeliveryCostOnlineOrder) ?? 0.0 }
        catch { totalDeliveryCostOnlineOrder = 0.0 }
        do { totalDeliveryCost = try container.decodeIfPresent(.totalDeliveryCost) ?? 0.0 }
        catch { totalDeliveryCost = 0.0 }
        do { discount = try container.decodeIfPresent(.discount) ?? 0.0 }
        catch { discount = 0.0 }
        
//        do { totalCreditCustomerOrderAmountCash = try container.decodeIfPresent(.totalCreditCustomerOrderAmountCash) ?? 0.0 }
//        catch { totalCreditCustomerOrderAmountCash = 0.0 }
        
        do { bonuses = try container.decodeIfPresent(.bonuses) ?? 0.0 }
        catch { bonuses = 0.0 }
        
        do { compensations = try container.decodeIfPresent(.compensations) ?? 0.0 }
        catch { compensations = 0.0 }
        
        do { balance = try container.decodeIfPresent(.balance) ?? 0.0 }
        catch { balance = 0.0 }
        
        do { payments = try container.decodeIfPresent(.payments) ?? 0.0 }
        catch { payments = 0.0 }
        
        do { collection = try container.decodeIfPresent(.collection) ?? 0.0 }
        catch { collection = 0.0 }
        
        
        do { endingBalance = try container.decodeIfPresent(.endingBalance) ?? 0.0 }
        catch { endingBalance = 0.0 }
        
    }
}
