//
//  DeliveryUser.swift
//  Capsula
//
//  Created by SherifShokry on 7/11/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import Foundation

struct DeliveryUser : Codable {
    
    let fullName : String?
    let email : String?
    let phoneNumber : String?
    let nationalId : String?
    let vehiclePlateLetters : String?
    let vehiclePlateNumber : Int?
    let bankAccountNumber : String?
    let accountHolderAddress : String?
    let personalPicture  : String?
    let driverLicensePicture : String?
    let idCardPicture : String?
    let carFromBehindPicture : String?
    let carFromFrontPicture  : String?
    let carRegistrationPicture :String?
    let nationalityDesc : String?
    let addressDesc : String?
    let vehicleTypeDesc : String?
    let yearDesc : String?
    let carModelDesc : String?
    let carTypeDesc : String?
    let nationalityId : Int?
    let carTypeId : Int?
    let carModelId : Int?
    let yearId : Int?
    let latitude : Double?
    let longitude : Double?
    let vehicleTypeId : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case fullName , email , phoneNumber , nationalId ,vehiclePlateLetters
        case vehiclePlateNumber,bankAccountNumber, accountHolderAddress,personalPicture,driverLicensePicture,idCardPicture,carFromBehindPicture,carFromFrontPicture,carRegistrationPicture,nationalityDesc,addressDesc, vehicleTypeDesc,yearDesc,carModelDesc,carTypeDesc, nationalityId, carTypeId,carModelId,yearId ,vehicleTypeId,longitude, latitude
    }
    
    init(){
        fullName = ""
        email  = ""
        phoneNumber  = ""
        nationalId  = ""
        vehiclePlateLetters  = ""
        vehiclePlateNumber  = -1
        bankAccountNumber = ""
        accountHolderAddress  = ""
        personalPicture   = ""
        driverLicensePicture  = ""
        idCardPicture  = ""
        carFromBehindPicture  = ""
        carFromFrontPicture  = ""
        carRegistrationPicture  = ""
        nationalityDesc  = ""
        addressDesc  = ""
        yearDesc = ""
        vehicleTypeDesc  = ""
        carModelDesc = ""
        carTypeDesc = ""
        nationalityId = -1
        carTypeId = -1
        carModelId = -1
        yearId = -1
        latitude = 0.0
        longitude = 0.0
        vehicleTypeId = -1
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {  fullName = try container.decodeIfPresent(.fullName) ?? ""}
        catch { fullName = "" }
        do {  email = try container.decodeIfPresent(.email) ?? ""}
        catch { email = "" }
        
        do {  phoneNumber = try container.decodeIfPresent(.phoneNumber) ?? ""}
        catch { phoneNumber = "" }
        
        do {  nationalId = try container.decodeIfPresent(.nationalId) ?? ""}
        catch { nationalId = "" }
        
        
        do {  vehiclePlateLetters = try container.decodeIfPresent(.vehiclePlateLetters) ?? ""}
        catch { vehiclePlateLetters = "" }
        
        do {  vehiclePlateNumber = try container.decodeIfPresent(.vehiclePlateNumber) ?? -1}
        catch { vehiclePlateNumber = -1  }
        
        do {  latitude = try container.decodeIfPresent(.latitude) ?? 0.0}
        catch { latitude = 0.0  }
        
        do {  longitude = try container.decodeIfPresent(.longitude) ?? 0.0}
         catch { longitude = 0.0  }
        
        
        do { vehicleTypeId = try container.decodeIfPresent(.vehicleTypeId) ?? -1}
        catch { vehicleTypeId = -1  }
        
        
  
    
        do {  carTypeId = try container.decodeIfPresent(.carTypeId) ?? -1}
        catch { carTypeId = -1  }
        
        do {  carModelId = try container.decodeIfPresent(.carModelId) ?? -1}
        catch { carModelId = -1  }
        
        
        
        do {  nationalityId = try container.decodeIfPresent(.nationalityId) ?? -1}
        catch { nationalityId = -1  }
        
        do {    yearId = try container.decodeIfPresent(.yearId) ?? -1}
        catch {  yearId = -1  }
        
        
        do {  accountHolderAddress = try container.decodeIfPresent(.accountHolderAddress) ?? ""}
        catch { accountHolderAddress = "" }
        
        
        do { personalPicture = try container.decodeIfPresent(.personalPicture) ?? ""}
        catch { personalPicture = "" }
        
        
        do {  driverLicensePicture = try container.decodeIfPresent(.driverLicensePicture) ?? ""}
        catch { driverLicensePicture = "" }
        
        
        do {  idCardPicture = try container.decodeIfPresent(.idCardPicture) ?? ""}
        catch { idCardPicture = "" }
        
        
        do {  carFromBehindPicture = try container.decodeIfPresent(.carFromBehindPicture) ?? ""}
        catch { carFromBehindPicture = "" }
        
        
        do { carFromFrontPicture = try container.decodeIfPresent(.carFromFrontPicture) ?? ""}
        catch { carFromFrontPicture = "" }
        
        
        do {  carRegistrationPicture = try container.decodeIfPresent(.carRegistrationPicture) ?? ""}
        catch { carRegistrationPicture = "" }
        
        do {  nationalityDesc = try container.decodeIfPresent(.nationalityDesc) ?? ""}
        catch { nationalityDesc = "" }
        
        do {   addressDesc = try container.decodeIfPresent(.addressDesc) ?? ""}
        catch {  addressDesc = "" }
        
        do {  vehicleTypeDesc = try container.decodeIfPresent(.vehicleTypeDesc) ?? ""}
        catch { vehicleTypeDesc = "" }
        
        do {  bankAccountNumber = try container.decodeIfPresent(.bankAccountNumber) ?? ""}
        catch { bankAccountNumber = "" }
        
        do { yearDesc = try container.decodeIfPresent(.yearDesc) ?? ""}
        catch { yearDesc = "" }
        
        do { carModelDesc = try container.decodeIfPresent(.carModelDesc) ?? ""}
        catch { carModelDesc = "" }
        
        do { carTypeDesc = try container.decodeIfPresent(.carTypeDesc) ?? ""}
        catch { carTypeDesc = "" }
    }
    
}
