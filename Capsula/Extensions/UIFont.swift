//
//  UIFont.swift
//  Fresh
//
//  Created by Karim abdelhameed mohamed on 1/29/18.
//  Copyright © 2018 bluecrunch. All rights reserved.
//
import Foundation
import UIKit

struct AppFontName {
    static let regular = "Almarai-Regular"
    static let bold = "Almarai-Bold"
    static let medium = "Almarai-Regular"
    static let italic = "Almarai-Light"
    static let semiBold = "Almarai-Regular"
    static let light =   "Almarai-Light"
    static let heavy =  "Almarai-Bold"
   

//    static let regular = "Cairo-Regular"
//    static let bold = "Cairo-Bold"
//    static let medium = "Cairo-SemiBold"
//    static let italic = "Cairo-Light"
//    static let semiBold = "Cairo-SemiBold"
//    static let light =  "Cairo-Light"
//    static let heavy =  "Cairo-Bold"
    

    static let regular_en = "Roboto-Regular"
    static let bold_en =    "Roboto-Bold"
    static let medium_en =  "Roboto-Medium"
    static let italic_en =  "Roboto-Light"
    static let semiBold_en = "Roboto-Medium"
    static let light_en =   "Roboto-Light"
    static let heavy_en =   "Roboto-Bold"

    
}

extension UIFont {

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func mySystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular_en, size: size)!
    }
    
    @objc class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont {
           return UIFont(name: AppFontName.medium, size: size)!
       }

       @objc class func myMediumSystemFontForEN(ofSize size: CGFloat) -> UIFont {
           return UIFont(name: AppFontName.medium_en, size: size)!
       }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func myBoldSystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold_en, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }

    @objc class func myItalicSystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic_en, size: size)!
    }

    @objc class func myHeavySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.heavy, size: size)!
    }

    @objc class func myHeavySystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.heavy_en, size: size)!
    }

    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: size)!
    }

    @objc class func myLightSystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light_en, size: size)!
    }

    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semiBold, size: size)!
    }

    @objc class func mySemiBoldSystemFontForEN(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semiBold_en, size: size)!
    }


    @objc convenience init(myCoder aDecoder: NSCoder) {
         if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
             let mFontAttribute = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
             if let fontAttribute = fontDescriptor.fontAttributes[mFontAttribute] as? String {
                 var fontName = ""
                 switch fontAttribute {
                 case "CTFontRegularUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.regular
                     } else {
                         fontName = AppFontName.regular_en
                     }
                     case "CTFontMediumUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.medium
                     } else {
                         fontName = AppFontName.medium_en
                     }
                 case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.bold
                     } else {
                         fontName = AppFontName.bold_en
                     }
                 case "CTFontObliqueUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.italic
                     } else {
                         fontName = AppFontName.italic_en
                     }
                 case "CTFontSemiboldUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.semiBold
                     } else {
                         fontName = AppFontName.semiBold_en
                     }
                 case "CTFontUltraLightUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.light
                     } else {
                         fontName == AppFontName.light_en
                     }
                 case "CTFontHeavyUsage":
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.heavy
                     } else {
                         fontName = AppFontName.heavy_en
                     }
                 default:
                     if (LocalizationSystem.sharedInstance.getLanguage() == "ar") {
                         fontName = AppFontName.regular
                     } else {
                         fontName = AppFontName.regular_en
                     }
                 }
                 self.init(name: fontName, size: fontDescriptor.pointSize)!
             } else {
                 self.init(myCoder: aDecoder)
             }
         } else {
             self.init(myCoder: aDecoder)
         }
     }


   class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)

            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)

            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)

            let lightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:)))
            let myLightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:)))
            method_exchangeImplementations(lightSystemFontMethod!, myLightSystemFontMethod!)

            let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:)))
            let mySemiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:)))
            method_exchangeImplementations(semiBoldSystemFontMethod!, mySemiBoldSystemFontMethod!)

            let heavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFont(ofSize:)))
            let myHeavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFont(ofSize:)))
            method_exchangeImplementations(heavySystemFontMethod!, myHeavySystemFontMethod!)
            
            let mediumSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFont(ofSize:)))
            let myMediumSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFont(ofSize:)))
            method_exchangeImplementations(mediumSystemFontMethod!, myMediumSystemFontMethod!)

            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }

    class func overrideInitializeForEN() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFontForEN(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)

            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFontForEN(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)

            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFontForEN(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)

            let lightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:)))
            let myLightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFontForEN(ofSize:)))
            method_exchangeImplementations(lightSystemFontMethod!, myLightSystemFontMethod!)

            let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:)))
            let mySemiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFontForEN(ofSize:)))
            method_exchangeImplementations(semiBoldSystemFontMethod!, mySemiBoldSystemFontMethod!)

            let heavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFont(ofSize:)))
            let myHeavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFontForEN(ofSize:)))
            method_exchangeImplementations(heavySystemFontMethod!, myHeavySystemFontMethod!)
            
            let mediumSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFontForEN(ofSize:)))
            let myMediumSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFontForEN(ofSize:)))
            method_exchangeImplementations(mediumSystemFontMethod!, myMediumSystemFontMethod!)

            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
