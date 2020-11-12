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
    case resetPassword(String , String, String)
    case checkPhoneIsExist(String,String)
    case updateUser(RegisterRequest)
    case updateDefaultAddress(Int)
    case changePassword(String,String)
    case getNotifications
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
        case .resetPassword(_, _,_): return "/ForgetPassword"
        case .checkPhoneIsExist(_,_): return ""
        case .updateUser(_): return "/UpdateUser"
        case .updateDefaultAddress(let addressId):
            return "/UpdateDefaultAddress/\(addressId)"
        case .changePassword(_,_):
            return "/ChangePassword"
        case .getNotifications:
            return "/GetNotifications"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addAddress(_, _, _):
            return .post
        case .resetPassword(_, _,_): return .post
        case .checkPhoneIsExist(_,_):  return .get
        case .updateUser(_): return .put
        case .updateDefaultAddress(_): return .put
        case .changePassword(_, _):
            return .put
        case .getNotifications:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .checkPhoneIsExist(_,_):
            return .requestPlain
        case .resetPassword(let mobile,let password,let token):
            var params = [String : Any]()
            params["phoneNumber"] = mobile
            params["newPassword"] = password
            params["token"] = token
            
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
            params["image"] = request.image
            
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateDefaultAddress(_):
            return .requestPlain
        case .changePassword(let currentPassword,let newPassword):
            var params = [String : Any]()
            params["currentPassword"] = currentPassword
            params["newPassword"] = newPassword
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getNotifications:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        let isDeliveryMan = UserDefaults.standard.bool(forKey: "isDelivery")
        if isDeliveryMan {
            return BaseDataSource.getDeliveryHeader() as? [String : String] ?? [:]
        }else{
            return BaseDataSource.getHeader() as? [String : String] ?? [:]
        }
        
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
