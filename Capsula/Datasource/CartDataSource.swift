//
//  CartDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 4/1/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum CartDataSource {
    case addCart([CartItem])
    case updateCart(CartItem)
    case deleteItem(Int)
    case deleteAll
    case validate
}

extension CartDataSource : TargetType {
    
    public var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/Cart")!
    }
  
    public var path: String {
        switch self {
        case .addCart:
            return "/Add"
        case .updateCart(_):
            return "/Update"
        case .deleteItem(let itemId):
            return "Delete/\(itemId)"
        case .deleteAll:
            return "/DeleteAll"
        case .validate:
            return "/Validate"
        }
    }
    
    public var method: Moya.Method {
        switch self {
         case .addCart:
            return .post
        case .updateCart(_):
            return .put
        case .deleteItem(_):
            return .delete
        case .deleteAll:
            return .delete
        case .validate:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .addCart(let cartList):
            
            let encoder = JSONEncoder()
            do {
                let result = try encoder.encode(cartList)
                
                return .requestData(result)
                
            } catch {
                
                print(error)
                return .requestPlain
            }
        case .updateCart(let cartItem):
            let encoder = JSONEncoder()
        do {
          let result = try encoder.encode(cartItem)
                return .requestData(result)
            } catch {
            print(error)
            return .requestPlain
          }
        case .deleteItem(_):
            return .requestPlain
        case .deleteAll:
            
             return .requestPlain
        case .validate:
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
