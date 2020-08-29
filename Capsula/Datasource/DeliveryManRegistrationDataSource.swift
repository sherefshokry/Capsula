//
//  DeliveryDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 6/30/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import Foundation
import Moya

public enum DeliveryManRegistrationDataSource {
     case getTermsAndConditions
     case getNationalities
     case getRegistrationBasicData
     case getCarModels(Int)
     case deliveryManRegister(DeliveryManRegisterRequest)
     case deliveryManLogin(LoginRequest)
     case updateDeliveryData(DeliveryRequest)
}

extension DeliveryManRegistrationDataSource : TargetType {
    
    public var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/DeliveryManRegisteration")!
    }
    
    public var path: String {
        switch self {
        case  .getTermsAndConditions : return "/GetTermsAndConditions"
        case .getNationalities: return "/GetNationalities"
        case .getRegistrationBasicData: return "/GetRegisterBasicData"
        case .getCarModels(let carTypeId): return "/GetCarModels/\(carTypeId)"
        case .deliveryManRegister(_): return "/Register"
        case .deliveryManLogin(_): return "/Login"
        case .updateDeliveryData(_): return "/Update"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTermsAndConditions : return .get
        case .getNationalities: return .get
        case .getRegistrationBasicData: return .get
        case .getCarModels(_): return .get
        case .deliveryManRegister(_): return .post
        case .deliveryManLogin(_): return .post
        case .updateDeliveryData(_): return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getTermsAndConditions : return .requestPlain
        case .getNationalities: return .requestPlain
        case .getRegistrationBasicData: return .requestPlain
        case .getCarModels(_): return .requestPlain
        case .deliveryManRegister(let request):
          return .requestParameters(parameters: request.getParams(), encoding: JSONEncoding.default)
        case .deliveryManLogin(let request):
            return .requestParameters(parameters: request.getParams(), encoding: JSONEncoding.default)
        case .updateDeliveryData(let request):
            
            
            return .requestParameters(parameters: request.getParams(), encoding: JSONEncoding.default)
        }
    }
    
    
    func getImageData(image : UIImage?)->Data?{
           if image != nil{
               return image!.jpegData(compressionQuality: 0.90)
           }
           return nil
       }
    
      public var headers: [String: String]? {
         return BaseDataSource.getDeliveryHeader() as? [String : String] ?? [:]
     }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
