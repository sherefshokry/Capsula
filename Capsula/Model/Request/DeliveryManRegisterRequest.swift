//
//  DeliveryManRegisterRequest.swift
//  Capsula
//
//  Created by SherifShokry on 6/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

public class DeliveryManRegisterRequest  : Codable {
    
    var name = ""
    var phone = ""
    var email = ""
    var nationalID = ""
    var bankAccount = ""
    var imageUrl = ""
    var vehiclePlateNumber = 0
    var nationalityId = -1
    var vehiclePlateLetters = ""
    var carTypeId = -1
    var carModelId = -1
    var vehicleTypeId = -1
    var yearId = -1
    var latitude = 0.0
    var longitude = 0.0
    var addressDesc = ""
    var carRegistrationPicture = ""
    var carFromFrontPicture = ""
    var carFromBehindPicture = ""
    var idCardPicture = ""
    var driverLicensePicture = ""
    
    init(){
    }
    
    func getParams() -> [String : Any]{
        var params = [String : Any]()
        
        params["fullName"] = name
        params["phoneNumber"] = phone
        params["email"] = email
        params["nationalId"] = nationalID
        params["vehiclePlateLetters"] = vehiclePlateLetters
        params["vehiclePlateNumber"] = vehiclePlateNumber
        params["bankAccountNumber"] = bankAccount
        params["nationalityId"] = nationalityId
        params["carTypeId"] = carTypeId
        params["carModelId"] = carModelId
        params["yearId"] = yearId
        params["vehicleTypeId"] = vehicleTypeId
        params["latitude"] = latitude
        params["longitude"] = longitude
        params["addressDesc"] = addressDesc
        params["personalPicture"] =  imageUrl
        params["driverLicensePicture"] = driverLicensePicture
        params["idCardPicture"] = idCardPicture
        params["carFromBehindPicture"] = carFromBehindPicture
        params["carFromFrontPicture"] = carFromFrontPicture
        params["carRegistrationPicture"] = carRegistrationPicture
        params["accountHolderAddress"] = addressDesc
        
       return params
    }
}
