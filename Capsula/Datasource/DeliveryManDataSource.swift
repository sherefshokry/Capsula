//
//  DeliveryManDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum DeliveryManDataSource {
    case getOrdersList
    case getFilteredOrdersHistory(String)
    case getOrderDetails(Int)
    case startDelivery(Int)
    case finishDelivery(Int)
    case getWallet
}

extension DeliveryManDataSource : TargetType {
    
    public var baseURL: URL {
            switch self {
                   case .getFilteredOrdersHistory(let filterDate):
                    return URL(string: "\(Constants.BASE_URL)/DeliveryMan/GetOrdersHistory?date=\(filterDate)")!
                   default:
                        return URL(string: "\(Constants.BASE_URL)/DeliveryMan")!
                   }
        
       
    }
  
    public var path: String {
        switch self {
        case .getOrdersList:
            return "/GetOrders"
        case .getOrderDetails(let orderID): return "/GetOrderDetails/\(orderID)"
        case .startDelivery(let orderID):
            return "/StartDelivery/\(orderID)"
        case .finishDelivery(let orderID):
            return "/EndDelivery/\(orderID)"
        case .getFilteredOrdersHistory(_):
            return ""
        case .getWallet:
            return "/Wallet"
        }
    }
    
    public var method: Moya.Method {
        switch self {
         case .getOrdersList:
            return .get
        case .getOrderDetails(_):
            return .get
        case .startDelivery(_):
            return .get
        case .finishDelivery(_):
            return .get
        case .getFilteredOrdersHistory(_):
            return .get
        case .getWallet:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getOrdersList:
            return .requestPlain
        case .getOrderDetails(_):
            return .requestPlain
        case .startDelivery(_):
            return .requestPlain
        case .finishDelivery(_):
            return .requestPlain
        case .getFilteredOrdersHistory(_):
            return .requestPlain
        case .getWallet:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return BaseDataSource.getDeliveryHeader() as? [String : String] ?? [:]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
