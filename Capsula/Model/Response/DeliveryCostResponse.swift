//
//  DeliveryCostResponse.swift
//  Capsula
//
//  Created by SherifShokry on 8/14/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation

struct  DeliveryCostResponse : Codable {
    
    let itemsCost : Double?
    let vatCost : Double?
    let deliveryCost : Double?
    let finalTotalCost : Double?
    let vatPercentage : Int?
    
    enum CodingKeys: String, CodingKey {
        case  itemsCost,vatCost,deliveryCost,finalTotalCost,vatPercentage
      }
    
    init(){
        itemsCost = 0.0
        vatCost = 0.0
        deliveryCost = 0.0
        finalTotalCost = 0.0
        vatPercentage = 0
      }
      
      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
        do {  itemsCost = try container.decodeIfPresent(.itemsCost) ?? 0.0 }
        catch {  itemsCost = 0.0 }
        do {  vatCost = try container.decodeIfPresent(.vatCost) ?? 0.0 }
            catch {  vatCost = 0.0 }
        do {  deliveryCost = try container.decodeIfPresent(.deliveryCost) ?? 0.0 }
            catch {  deliveryCost = 0.0 }
        do { finalTotalCost = try container.decodeIfPresent(.finalTotalCost) ?? 0.0 }
            catch {  finalTotalCost = 0.0 }
        do { vatPercentage = try container.decodeIfPresent(.vatPercentage) ?? 0 }
        catch {  vatPercentage = 0 }
      }
    
    
    
    
}
