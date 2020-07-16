//
//  CheckOutDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 4/20/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum CheckOutDataSource {
    case checkout(CheckoutRequest)
    case ordersList
    case orderTrackingList(Int)
    case orderDetails(Int)
    case cancelOrder(Int)
}

extension CheckOutDataSource : TargetType {
    
    public var baseURL: URL {
        
     
         switch self {
            case .cancelOrder(let orderId):
            return URL(string: "\(Constants.BASE_URL)/Order/CancelOrder?orderId=\(orderId)")!
         case .orderTrackingList(let orderId):
             return URL(string: "\(Constants.BASE_URL)/Order/GetOrderTracking?orderId=\(orderId)")!
        case .orderDetails(let orderId):
            return URL(string: "\(Constants.BASE_URL)/Order/GetOrderDetails?orderId=\(orderId)")!
            default:
            return URL(string: "\(Constants.BASE_URL)")!
        }}
  
    public var path: String {
        switch self {
        case .checkout(_):
            return "/CheckOut"
        case .ordersList:
            return "/Order/GetOrders"
        case .orderTrackingList(_):
            return ""
        case .orderDetails(_):
            return ""
        case .cancelOrder(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
         case .checkout(_):
            return .post
        case .ordersList:
            return .get
        case .orderTrackingList:
            return .get
        case .orderDetails(_):
            return .get
        case .cancelOrder(_):
            return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .checkout(let request):
           return .requestParameters(parameters: request.getParams(), encoding: JSONEncoding.default)
        case .ordersList:
            return .requestPlain
        case .orderTrackingList(_):
            return .requestPlain
        case .orderDetails(_):
            return .requestPlain
        case .cancelOrder(_):
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return BaseDataSource.getHeader() as? [String : String] ?? [:]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
