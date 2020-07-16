//
//  ItemDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum ItemsDataSource {
    case getItemsData(Int)
    case getItemsDataWithCategoryId(Int)
    case getTopSellingItems
    case getTopRatingItems
    case getFreeDliveryITems
    case itemsSearch(String,Int)
    case getItemsDataWithStoreId(Int,Int)
}

extension ItemsDataSource : TargetType {
    
    public var baseURL: URL {
        switch self {
             case .getItemsData(let brandId):
                return URL(string: "\(Constants.BASE_URL)/Item/GetItemsByBrandId?brandId=\(brandId)")!
            case .getItemsDataWithCategoryId(let categoryId):
            return URL(string: "\(Constants.BASE_URL)/Item/GetItemsBySubCategoryId?subCategoryId=\(categoryId)")!
             case .getItemsDataWithStoreId(let categoryId, let storeId):
                       return URL(string: "\(Constants.BASE_URL)/Item/GetItemsByStoreCategoryId?categoryId=\(categoryId)&storeId=\(storeId)")!
            
            case .itemsSearch(let searchText, let filterType):
               let urlString = "\(Constants.BASE_URL)/Item/ItemsSearch?itemName=\(searchText)&filterType=\(filterType)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return URL(string: urlString)!
             default:
                  return URL(string: "\(Constants.BASE_URL)/Item")!
             }
    }
  
    public var path: String {
        switch self {
        case .getItemsData(_):
            return ""
        case .getTopSellingItems:
            return "/GetTopSellingItems"
        case .getTopRatingItems:
            return "/GetTopRatingItems"
        case .getItemsDataWithCategoryId(_):
            return ""
        case .itemsSearch(_,_):
            return ""
        case .getFreeDliveryITems:
            return "/GetFreeDeliveryItems"
        case .getItemsDataWithStoreId(_, _):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
         case .getItemsData:
            return .get
        case .getTopSellingItems:
            return .get
        case .getTopRatingItems:
            return .get
        case .getItemsDataWithCategoryId(_):
            return .get
        case .itemsSearch(_, _):
            return .get
        case .getFreeDliveryITems:
            return .get
        case .getItemsDataWithStoreId(_, _):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getItemsData:
            return .requestPlain
        case .getTopSellingItems:
            return .requestPlain
        case .getTopRatingItems:
            return .requestPlain
        case .getItemsDataWithCategoryId(_):
            return .requestPlain
        case .itemsSearch(_, _):
            return .requestPlain
        case .getFreeDliveryITems:
            return .requestPlain
        case .getItemsDataWithStoreId(_, _):
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

