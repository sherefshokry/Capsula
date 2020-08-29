//
//  DeliveryRequest.swift
//  Capsula
//
//  Created by SherifShokry on 8/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import Foundation
import UIKit

public class DeliveryRequest  : Codable {
    
    var email = ""
    var phone = ""
    var vehiclePlateLetters = ""
    var vehiclePlateNumber = -1
    var bankAccountNumber = ""
    var accountHolderAddress = ""
    var personalPicture = ""
    var driverLicensePicture = ""
    var idCardPicture = ""
    var carFromBehindPicture = ""
    var carFromFrontPicture = ""
    var carRegistrationPicture  = ""
    var nationalityId = -1
    var carTypeId  = -1
    var carModelId = -1
    var yearId = -1
    var vehicleTypeId = -1
    var latitude = 0.0
    var longitude = 0.0
    var addressDesc = ""

    init(){
    }
    
    func getParams() -> [String : Any]{
        var params = [String : Any]()
        params["email"] = email
        params["phoneNumber"] = phone
        params["vehiclePlateLetters"] = vehiclePlateLetters
        params["vehiclePlateNumber"] = vehiclePlateNumber
        params["bankAccountNumber"] = bankAccountNumber
        params["accountHolderAddress"] = accountHolderAddress
        params["personalPicture"] = personalPicture
        params["driverLicensePicture"] = driverLicensePicture
        params["idCardPicture"] = idCardPicture
        params["carFromBehindPicture"] = carFromBehindPicture
        params["carFromFrontPicture"] = carFromFrontPicture
        params["carRegistrationPicture"] = carRegistrationPicture
        params["nationalityId"] = nationalityId
        params["carTypeId"] = carTypeId
        params["carModelId"] = carModelId
        params["yearId"] = yearId
        params["vehicleTypeId"] = vehicleTypeId
        params["latitude"] = latitude
        params["longitude"] = longitude
        params["addressDesc"] = addressDesc
        

       return params
    }
}
