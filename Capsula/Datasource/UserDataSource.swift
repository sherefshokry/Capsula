//
//  UserDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 1/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import Foundation
import Moya

public enum UserDataSource {
    case addAddress(String , Double , Double)
    case resetPassword(String , String)
    case checkPhoneIsExist(String,String)
    case updateUser(RegisterRequest)
    case updateDefaultAddress(Int)
}

extension UserDataSource : TargetType {
    
    public var baseURL: URL {
        switch self {
               case .checkPhoneIsExist(let phoneNumber, let email):
                return URL(string: "\(Constants.BASE_URL)/UserProfile/CheckUserExist?PhoneNumber=\(phoneNumber)&email=\(email)")!
               default:
                     return URL(string: "\(Constants.BASE_URL)/UserProfile")!
               }
    
    }
    
    public var path: String {
        switch self {
        case .addAddress(_, _, _):  return "/AddUserAddress"
            
        case .resetPassword(_, _): return "/ChangeUserPassword"
        case .checkPhoneIsExist(_,_): return ""
        case .updateUser(_): return "/UpdateUser"
        case .updateDefaultAddress(let addressId):
            return "/UpdateDefaultAddress/\(addressId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addAddress(_, _, _):
            return .post
        case .resetPassword(_, _): return .post
        case .checkPhoneIsExist(_,_):  return .get
        case .updateUser(_): return .put
        case .updateDefaultAddress(_): return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .checkPhoneIsExist(_,_):
            return .requestPlain
        case .resetPassword(let mobile,let password):
            var params = [String : Any]()
            params["phoneNumber"] = mobile
            params["newPassword"] = password
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .addAddress(let address,let latitude,let longitude):
            var params = [String : Any]()
            params["addressDesc"] = address
            params["latitude"] = latitude
            params["longitude"] = longitude
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateUser(let request):
            var params = [String : Any]()
            params["name"] = request.name
            params["email"] = request.email
            params["phone"] = request.phone
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateDefaultAddress(_):
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
