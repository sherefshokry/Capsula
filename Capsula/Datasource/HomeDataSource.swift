//
//  HomeDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation
import Moya

public enum HomeDataSource {
    case getHomeData
    case updateUserData
    
}

extension HomeDataSource : TargetType {
    
    public var baseURL: URL {
        switch self {
        case .updateUserData:
            return URL(string: "\(Constants.BASE_URL)/Cart/GetContent")!
        default:
            return URL(string: "\(Constants.BASE_URL)/Home")!
        }
        
        
    }
    
    public var path: String {
        switch self {
        case .getHomeData:
            return "/GetHomeData"
        case .updateUserData:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getHomeData:
            return .get
            
        case .updateUserData:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case . getHomeData:
            return .requestPlain
        case .updateUserData:
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
