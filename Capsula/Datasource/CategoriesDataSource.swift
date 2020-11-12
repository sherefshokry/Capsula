//
//  CategoriesDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 2/7/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum CategoriesDataSource {
    case getCategoriesData(Int)
    case getCategoriesDataWithStoreId(Int,Int)
    case getSubCategoriesData(Int)
    case getSubCategoriesDataByStoreId(Int , Int)
}

extension CategoriesDataSource : TargetType {
    
    public var baseURL: URL {
        
        switch self {
        case .getCategoriesDataWithStoreId(let storeId,let page):
            return URL(string: "\(Constants.BASE_URL)/Category/GetCategoriesByStoreId?storeId=\(storeId)&PageNumber=\(page)&PageSize=\(Constants.per_page)")!
        case .getCategoriesData(let page):
            return URL(string: "\(Constants.BASE_URL)/Category/GetCategories?PageNumber=\(page)&PageSize=\(Constants.per_page)")!
        case .getSubCategoriesData(let categoryId):
           return URL(string: "\(Constants.BASE_URL)/Category/GetSubCategories?categoryId=\(categoryId)")!
        case .getSubCategoriesDataByStoreId(let categoryId,let storeId):
            return URL(string: "\(Constants.BASE_URL)/Category/GetSubCategoriesByStoreId?categoryId=\(categoryId)&storeId=\(storeId)")!
//        default:
//             return URL(string: "\(Constants.BASE_URL)/Category")!
        }
        
       
    }
  
    public var path: String {
        switch self {
        case .getCategoriesData:
            return ""
        case .getSubCategoriesData(_):
            return ""
        case .getCategoriesDataWithStoreId(_,_):
            return ""
        case .getSubCategoriesDataByStoreId(_, _):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
         case .getCategoriesData:
            return .get
        case .getSubCategoriesData(_):
            return .get
        case .getCategoriesDataWithStoreId(_,_):
            return .get
        case .getSubCategoriesDataByStoreId(_, _):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case . getCategoriesData:
            return .requestPlain
        case .getSubCategoriesData(_):
            return .requestPlain
        case .getCategoriesDataWithStoreId(_,_):
            return .requestPlain
        case .getSubCategoriesDataByStoreId(_, _):
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
