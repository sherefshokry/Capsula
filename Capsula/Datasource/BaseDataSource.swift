//
//  BaseDataSource.swift
//  Mansour
//
//  Created by SherifShokry on 11/4/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//
import Foundation

enum State {
  case loading
  case ready
  case error(String)
}

class BaseDataSource {
     static func getHeader() -> [String: Any] {
        var header = [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Accept-Language": LocalizationSystem.sharedInstance.getLanguage()]
       
        if let user = Utils.loadUser() {
            
            header["Authorization"] = "Bearer \(user.accessToken ?? "")"
            
            
        }

            return header
        }
    
    
    
    static func getDeliveryHeader() -> [String: Any] {
       var header = [
               "Content-Type": "application/json",
               "Accept": "application/json",
               "Accept-Language": LocalizationSystem.sharedInstance.getLanguage()]
      
       if let user = Utils.loadDeliveryUser() {
           header["Authorization"] = "Bearer \(user.accessToken ?? "")"
       }

           return header
       }
 
}


