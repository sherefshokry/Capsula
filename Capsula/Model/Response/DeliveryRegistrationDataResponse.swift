//
//  DeliveryRegistrationData.swift
//  Capsula
//
//  Created by SherifShokry on 7/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//




import Foundation

struct DeliveryRegistrationDataResponse : Codable {
    var  carTypes : [CarType]?
    var  years : [CarType]?
    var  vehicleTypes : [CarType]?
    
   enum CodingKeys: String, CodingKey {
      case  carTypes,years,vehicleTypes
    }
    
    init(){
    carTypes = []
    years = []
    vehicleTypes = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do { carTypes = try container.decodeIfPresent(.carTypes) ?? [] }
        catch { carTypes = [] }
        do { years = try container.decodeIfPresent(.years) ?? [] }
               catch { years = [] }
        do { vehicleTypes = try container.decodeIfPresent(.vehicleTypes) ?? [] }
               catch { vehicleTypes = [] }
    }
}
