//
//  VerificationDataSource.swift
//  Capsula
//
//  Created by SherifShokry on 1/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import Foundation
import Firebase

class VerificationDataSource {
    
    
    public enum ResponseStatus: String {
          case error = "error"
          case sucess = "success"
          case networkError = "networkError"
      }
      
    func sendVerificationSMS(phoneNumber : String , completion:@escaping(ResponseStatus,String) -> ()){
        
        PhoneAuthProvider.provider().verifyPhoneNumber("\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                completion(.error  , (error?.localizedDescription)!)
            } else {
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVerificationID")
                completion(.sucess, verificationID!)
            }
        }
    }
    
    
     func verifyPhoneNumber(code: String,completion:@escaping(ResponseStatus,Any)->()) {
         
         let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
         let credential = PhoneAuthProvider.provider().credential(
             withVerificationID: verificationID!,
             verificationCode: code)
         Auth.auth().signIn(with: credential) { (authResult, error) in
             if error != nil {
                 completion(.error ,LocalizationSystem.sharedInstance.localizedStringForKey(key: "Verification_Code", comment: ""))
                 return
             }
             var firebaseToken = ""
             
             authResult?.user.getIDToken(completion: { (fetchedToken, error) in
                 if error != nil {
                     
                 }
                 
                 
                 firebaseToken  = fetchedToken ?? ""
                 completion(.sucess,firebaseToken)
                 
             })
             
         }
     }
     
    
    
}
