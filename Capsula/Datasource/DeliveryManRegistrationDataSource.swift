//
//  DeliveryDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 6/30/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import Moya

public enum DeliveryManDataSource {
     case getTermsAndConditions
     case getNationalities
     case getRegistrationBasicData
     case getCarModels(Int)
     case deliveryManRegister(DeliveryManRegisterRequest)
    
}

extension DeliveryManDataSource : TargetType {
    
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
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTermsAndConditions : return .get
        case .getNationalities: return .get
        case .getRegistrationBasicData: return .get
        case .getCarModels(_): return .get
        case .deliveryManRegister(_): return .post
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
            

//            let memberIdData = "\(request.nationalID)".data(using: String.Encoding.utf8) ?? Data()
//            var formData: [Moya.MultipartFormData] =
//            [Moya.MultipartFormData(provider: .data(request.getParams()["personalPicture"]! as! Data), name: "personalPicture", fileName: "personalPicture.png", mimeType: "image/*"),
//            Moya.MultipartFormData(provider: .data(request.getParams()["driverLicensePicture"]! as! Data), name: "driverLicensePicture", fileName: "driverLicensePicture.png", mimeType: "image/*"),
//              Moya.MultipartFormData(provider: .data(request.getParams()["idCardPicture"]! as! Data), name: "idCardPicture", fileName: "idCardPicture.png", mimeType: "image/*"),
//               Moya.MultipartFormData(provider: .data(request.getParams()["carFromBehindPicture"]! as! Data), name: "carFromBehindPicture", fileName: "carFromBehindPicture.png", mimeType: "image/*"),
//                   Moya.MultipartFormData(provider: .data(request.getParams()["carFromFrontPicture"]! as! Data), name: "carFromFrontPicture", fileName: "carFromFrontPicture.png", mimeType: "image/*"),
//                    Moya.MultipartFormData(provider: .data(request.getParams()["carRegistrationPicture"]! as! Data), name: "carRegistrationPicture", fileName: "carRegistrationPicture.png", mimeType: "image/*"),
//            ]
//
//             formData.append(Moya.MultipartFormData(provider: .data(memberIdData), name: "user_id"))
//
//             var params = [String : Any]()
//            params["fullName"] = request.name
//            params["phoneNumber"]  = request.phone
//            params["email"] = request.email
//            params["nationalId"] = request.nationalID
//            params["vehiclePlateLetters"] = request.vehiclePlateLetters
//            params["vehiclePlateNumber"] = request.vehiclePlateNumber
//            params["bankAccountNumber"] = request.bankAccount
//            params["nationalityId"] = request.nationalID
//            params["carTypeId"] =  request.carTypeId
//            params["carModelId"] = request.carModelId
//            params["yearId"] = request.yearId
//            params["vehicleTypeId"] = request.vehicleTypeId
//            params["latitude"] = request.latitude
//            params["longitude"] = request.longitude
//            params["addressDesc"] = request.addressDesc
//            params["accountHolderAddress"] = request.addressDesc
            
        //    return .uploadCompositeMultipart(formData, urlParameters: params)
        }
    }
    
    
    func getImageData(image : UIImage?)->Data?{
           if image != nil{
               return image!.jpegData(compressionQuality: 0.90)
           }
           return nil
       }
    
    public var headers: [String: String]? {
        return BaseDataSource.getHeader() as? [String : String] ?? [:]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
