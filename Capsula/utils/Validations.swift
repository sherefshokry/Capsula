//
//  Validations.swift
//  MyLexus
//
//  Created by Nora on 6/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation

class Validations {

       static func isValidPhoneNumber (text : String) -> Bool{
        //regex for saudi arabia phone number
        let regEx = "^(5)(5|0|3|6|4|9|1|8|7)[0-9]{7}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: text)
        
    }
    
    static func doStringContainsNumber(text : String) -> Bool{
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: text)
        
        return containsNumber
    }
    
    static func isValidEmail(text : String) -> Bool {

//        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let regEx = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: text)
    }
    
    static func textHasOnlyNumbers(_ text: String) -> Bool {
        
        let charcterSet  = CharacterSet(charactersIn: "0123456789").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  text == filtered
    }
    
    static func isValidKiloMeter(_ text : String) -> Bool {
        
        let km = Int(text) ?? 0
        let status = (km <= 100000 && km > 99) ? true : false
        return status
        
    }
    
    static func hasCharOnly(_ text : String) -> Bool {
   
        return  CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: text))
    
    }
    
    static func textHasOnlyNumbersAndFloatingPoint(_ text: String) -> Bool {
        let charcterSet  = CharacterSet(charactersIn: "0123456789.").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  text == filtered
    }
    
   static func hasSpecialCharOnly(_ text : String) -> Bool {
     let specialChar = CharacterSet(charactersIn:
        "\\-|!#$%&/()=?»«@£§€{}.-;'<>_,*").inverted

     let inputString  = text.components(separatedBy: specialChar)
     let filtered = inputString.joined(separator: "")
    return text == filtered
    }
    
    static func hasSpecialChar(_ text : String) -> Bool {
        let specialChar = CharacterSet(charactersIn:
            "\\-|!#$%&/()=?»«@£§€{}.-;'<>_,").inverted
        
        let inputString  = text.components(separatedBy: specialChar)
        let filtered = inputString.joined(separator: "")
        return filtered.count > 0
    }

    static func hasSpecialCharAndNumbersOnly(_ text : String) -> Bool {

        let specialChar = CharacterSet(charactersIn:
            "\\-|!#$%&/()=?»«@£§€{}.-;'<>_,0123456789").inverted

        let inputString  = text.components(separatedBy: specialChar)
        let filtered = inputString.joined(separator: "")
        return text == filtered
  }

    static func isValidPassword(text: String)->Bool{
    
//
//        if textHasOnlyNumbers(text){
//            return false
//        }
//
//        if hasSpecialCharOnly(text){
//            return false
//        }
//
//        if hasSpecialCharAndNumbersOnly(text){
//        return false
//        }
        
        
//        if hasCharOnly(text){
//            return false
//        }
        
        if text.count < 6 {
            return false
        }

        return true
    
    }
    
    static func isValidIDNumber(text: String)->Bool{
            return textHasOnlyNumbers(text) && text.count == 18
        }
    
    static func isValidTransferAmount(text: String)->Bool{
//        if let cost = Int(text) {
//            return textHasOnlyNumbers(text) && cost > 0 &&
//                cost <= SessionManager.USER_TOTAL_BALANCE
//        }
        return false
    }
    
    static func isValidName(string : String)->Bool{
        
        if textHasOnlyNumbers(string){
            return false
        }

        if hasSpecialCharOnly(string){
            return false
        }

        if hasSpecialCharAndNumbersOnly(string){
        return false
        }

        let regex =  "^([0-9a-zA-Zء-ي ]).{3,1000}$"
        let userTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return userTest.evaluate(with: string) || hasSpecialChar(string)
    }




}
