//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    
    //    func substring(_ from: Int) -> String {
    //        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    //    }
    
    func isNumeric() -> Bool
    {
        let number = Int(self)
        return number != nil
    }
    
    func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    func updateToEngNum()->String{
        var text = ""
        text = self.replacingOccurrences(of: "٠", with: "0")
        text = text.replacingOccurrences(of: "١", with: "1")
        text = text.replacingOccurrences(of: "٢", with: "2")
        text = text.replacingOccurrences(of: "٣", with: "3")
        text = text.replacingOccurrences(of: "٤", with: "4")
        text = text.replacingOccurrences(of: "٥", with: "5")
        text = text.replacingOccurrences(of: "٦", with: "6")
        text = text.replacingOccurrences(of: "٧", with: "7")
        text = text.replacingOccurrences(of: "٨", with: "8")
        text = text.replacingOccurrences(of: "٩", with: "9")
        return text
    }
    
   
    
    
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "ar")
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEEE"
        let dayName = dateFormatter.string(from: date ?? Date())
        //        let indexStartOfText = dayName.index(dayName.startIndex, offsetBy: 3)
        //        dayName =  String(dayName[..<indexStartOfText])
        dateFormatter.dateFormat = "dd"
        let dayNumber = dateFormatter.string(from: date ?? Date())
        dateFormatter.dateFormat = "LLLL"
        let monthName = dateFormatter.string(from: date ?? Date())
        //        monthName =  String(monthName[..<indexStartOfText])
        
        return  dayName + " " + dayNumber + " " + monthName
    }
    
    func getTopicName() -> String {
        var  name = self.replacingOccurrences(of: " ", with: "_")
        name = name.lowercased()
        name = "\(name)"
        return name
    }
    
    func getDateWithoutTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEEE"
        var dayName = dateFormatter.string(from: date ?? Date())
        let indexStartOfText = dayName.index(dayName.startIndex, offsetBy: 3)
        dayName =  String(dayName[..<indexStartOfText])
        dateFormatter.dateFormat = "dd"
        let dayNumber = dateFormatter.string(from: date ?? Date())
        dateFormatter.dateFormat = "LLLL"
        var monthName = dateFormatter.string(from: date ?? Date())
        monthName =  String(monthName[..<indexStartOfText])
        
        return   dayNumber + " " + monthName
    }
    
    
    func getTime() -> String {
        var time = ""
        let inFormatter = DateFormatter()
        let outFormatter = DateFormatter()
        inFormatter.dateFormat = "hh:mm:ss a"
        let date = inFormatter.date(from: self)
        outFormatter.dateFormat = "hh"
        let hour = outFormatter.string(from: date ?? Date())
        outFormatter.dateFormat = "mm"
        let minutes = outFormatter.string(from: date ?? Date())
        outFormatter.dateFormat = "a"
        let amOrPm = outFormatter.string(from: date ?? Date())
        time = hour + ":" + minutes + " " + amOrPm
        return  time
    }
    
    
    func getAttributedString(color : UIColor , font : UIFont) -> NSAttributedString {
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        return attributedString
        
    }
    
    func monthDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd MMM yyyy"
        return  dateFormatter.string(from: date!)
    }
    
    
    func timeFormat() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
           let date = dateFormatter.date(from: self)
           dateFormatter.dateFormat = "HH:mm a"
           return  dateFormatter.string(from: date!)
       }
    
    func monthFormat() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            let date = dateFormatter.date(from: self)
            dateFormatter.dateFormat = "dd-MMM-yyy"
            return  dateFormatter.string(from: date!)
        }
    
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }
    
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, count)]))
        }
        return result
    }
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
    
    func doStringContainsNumber( ) -> Bool{
        
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: self)
        
        return containsNumber
    }
    
    func isValidPhoneNumber () -> Bool{
        if  self.count == 11 && isNumeric(){
            let prefix = String(self.prefix(3))
            if prefix == "010" || prefix == "011" || prefix == "012" ||  prefix == "015"  || prefix == "٠١٠" || prefix == "٠١١" || prefix == "٠١٢" || prefix == "٠١٥"
            {
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    
    func trim ()->String{
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    func formatDate() -> String{
        if(self.count > 0 ){
            let indexStartOfText = self.index(self.startIndex, offsetBy: 8)
            let mSubString = String(self[..<indexStartOfText])
            let yearStartIndex = mSubString.index(self.startIndex , offsetBy : 4)
            let year = String (self[..<yearStartIndex])
            
            
            let startMonth = mSubString.index(mSubString.startIndex, offsetBy: 4)
            let endMonth = mSubString.index(mSubString.endIndex, offsetBy: -2)
            let rangeMonth = startMonth..<endMonth
            
            let month = String(mSubString[rangeMonth])
            
            let startDay = mSubString.index(mSubString.startIndex, offsetBy: 6)
            let endDay = mSubString.index(mSubString.endIndex, offsetBy: 0)
            let rangeDay = startDay..<endDay
            
            let day = String(mSubString[rangeDay])
            
            let myMonth = DateFormatter().monthSymbols[(Int(month) ?? 0) - 1]
            
            return myMonth  + " " + day + ",\n" + year
        }
        return ""
    }
    
    
    
    func toDate () -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "yyyy"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        return Date()
        
    }
    func toDateWithoutTime () -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "yyyy"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        return Date()
        
    }
    
    static func getURL(baseURL: String, params: Dictionary<String, String?>) -> String {
        var url = baseURL + "?"
        for  item in params  {
            if item.value != nil {
                url = url + item.key + "=" + item.value!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&"
            }
        }
        url = url.substring(to: url.index(before: url.endIndex))
        
        return url
    }
    
    
    func localize() -> String{
        return NSLocalizedString(self, comment: self)
    }
    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
