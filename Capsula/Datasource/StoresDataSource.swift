//
//  StoresDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 2/7/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation
import Moya

public enum StoresDataSource {
    case getStoresData(Int)
}

extension StoresDataSource : TargetType {
    
    public var baseURL: URL {
    
          switch self {
             case .getStoresData(let page) :
                return URL(string: "\(Constants.BASE_URL)/Store/GetStores?PageNumber=\(page)&PageSize=\(Constants.per_page)")!
        }
    }

    public var path: String {
        switch self {
        case .getStoresData:
            return ""
       }
    }
    
    public var method: Moya.Method {
        switch self {
         case .getStoresData:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getStoresData:
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
