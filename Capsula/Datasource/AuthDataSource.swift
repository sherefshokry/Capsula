//
//  UserDataSource.swift
//  Mansour
//
//  Created by SherifShokry on 11/27/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//
import Foundation
import Moya

public enum AuthDataSource {
    case Register(RegisterRequest)
    case LogIn(LoginRequest)
    case LogInWithfacebook(String)
    case LogInWithTwitter(String,String)
    case LogInWithGoogle(String)
    case LogOut
}

extension AuthDataSource : TargetType {
    
    public var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/Authentication")!
    }
    
    public var path: String {
        switch self {
        case .Register(_) : return "/Register"
        case .LogIn(_): return "/Login"
        case .LogInWithfacebook(_): return "/Facebook"
        case .LogInWithTwitter(_, _): return "/Twitter"
        case .LogInWithGoogle(_): return "/Google"
        case .LogOut:
            return "/Logout"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .Register : return .post
        case .LogIn : return .post
        case .LogInWithfacebook(_): return .post
        case .LogInWithTwitter(_, _): return .post
        case .LogInWithGoogle(_): return .post
        case .LogOut: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .Register(let registerRequest):
            return .requestParameters(parameters: registerRequest.getParams(), encoding: JSONEncoding.default)
        case .LogIn(let logInRequest):
            return .requestParameters(parameters: logInRequest.getParams(), encoding: JSONEncoding.default)
            
        case .LogInWithfacebook(let token):
            var params = [String : Any]()
            params["token"] = token
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .LogInWithTwitter(let token,let secret):
            var params = [String : Any]()
            params["token"] = token
            params["secret"] = secret
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .LogInWithGoogle(let token):
            var params = [String : Any]()
            params["token"] = token
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .LogOut:
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
