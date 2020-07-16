//
//  BrandsDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import Foundation
import Moya

public enum BrandsDataSource {
    case getBrandsData
}

extension BrandsDataSource : TargetType {
    
    public var baseURL: URL {
        
        
        return URL(string: "\(Constants.BASE_URL)/Brand")!
    }
  
    public var path: String {
        switch self {
        case .getBrandsData:
            return "/GetBrands"
       }
    }
    
    public var method: Moya.Method {
        switch self {
         case .getBrandsData:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getBrandsData:
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
