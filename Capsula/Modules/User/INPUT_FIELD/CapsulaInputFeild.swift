//
//  MastersInputFeild.swift
//  Masters
//
//  Created by Nora on 3/5/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//
import Foundation
import UIKit

class CapsulaInputFeild : InputField {
    
    @IBOutlet weak var nextFeild : CapsulaInputFeild!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextFeildSpecs()
    }
    
    func setTextFeildSpecs(){
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            self.field.textAlignment = .right
        }else{
            self.field.textAlignment = .left
        }
        
        switch type {
        case .notRequired:
            self.field.keyboardType = .asciiCapable
            break
        case .age:
            self.field.keyboardType = .asciiCapableNumberPad
            break
        case .email:
            self.titleLabel.text = Strings.Fields.shared.email
            self.field.keyboardType = .asciiCapable
            break
        case .password:
             self.titleLabel.text = Strings.shared.password
             self.field.font = .systemFont(ofSize: 18)
            self.field.keyboardType = .asciiCapable
            self.field.isSecureTextEntry = true
        case .newPassword:
            self.titleLabel.text = Strings.shared.newPassword
             self.field.font = .systemFont(ofSize: 18)
            self.field.keyboardType = .asciiCapable
            self.field.isSecureTextEntry = true
            break
        case .phoneNumber:
            self.lineView.semanticContentAttribute = .forceLeftToRight
             self.titleLabel.text = Strings.Fields.shared.phone
            self.eyeView.isHidden = false
            self.field.keyboardType = .asciiCapableNumberPad
            self.numberLabel.isHidden = false
           // self.seperatorView.isHidden = false
            self.numberViewWidthConstraint.constant = 60
            break
        case .name:
             self.titleLabel.text = Strings.Fields.shared.name
            self.field.keyboardType = .default
            break
        case .action:
            self.topBtn.isHidden = false
            self.topView.isHidden = false
         //   self.verticalLineView.isHidden = false
         //   self.sideImage.isHidden = false
            break
        case .regular:
            //            self.field.keyboardType = .asciiCapable
            break
        case .eyePassword:
            self.field.isSecureTextEntry = true
            self.field.keyboardType = .asciiCapable
            //            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            //                self.lineView.semanticContentAttribute = .forceRightToLeft
            //                 self.numberView.semanticContentAttribute = .forceLeftToRight
            //            }else{
            //
            //            }
            self.lineView.semanticContentAttribute = .forceRightToLeft
            self.numberView.semanticContentAttribute = .forceRightToLeft
            
            self.seperatorView.isHidden = false
            self.eyeButton.isHidden = false
            self.numberViewWidthConstraint.constant = 50
            break
            
        case .eyePasswordNoValidation:
            self.field.isSecureTextEntry = true
            self.field.keyboardType = .asciiCapable
            //            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            //                self.lineView.semanticContentAttribute = .forceRightToLeft
            //                self.numberView.semanticContentAttribute = .forceLeftToRight
            //            }else{
            //
            //            }
            self.lineView.semanticContentAttribute = .forceRightToLeft
            self.numberView.semanticContentAttribute = .forceRightToLeft
            // self.lineView.semanticContentAttribute = .forceRightToLeft
            // self.numberView.semanticContentAttribute = .forceRightToLeft
            self.seperatorView.isHidden = false
            self.eyeButton.isHidden = false
            self.numberViewWidthConstraint.constant = 50
            break
        case .number:
            self.titleLabel.text = Strings.shared.password
            self.field.font = .systemFont(ofSize: 18)
            self.field.isSecureTextEntry = true
            self.field.keyboardType = .asciiCapable
        case .confirmPassword:
            self.titleLabel.text = Strings.shared.confirmationPassword
            self.field.isSecureTextEntry = true
            self.field.keyboardType = .asciiCapable
        case .no:
            self.field.keyboardType = .asciiCapableNumberPad
            break
        case .VinNo:
            // self.field.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Vin_Holder", comment: "")
            self.field.keyboardType = .asciiCapable
            break
        case .PlateNo:
            
            // self.field.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Plate_Holder", comment: "")
            
            self.field.keyboardType = .default
            break
        case .phoneOrEmail:
            self.titleLabel.text = Strings.Fields.shared.phoneOrEmail
            self.field.keyboardType = .asciiCapable
        }
        if nextFeild != nil{
            field.returnKeyType = .next
        }else{
            field.returnKeyType = .done
        }
        
        self.field.placeHolderColor = UIColor.red
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let returnValue = super.textFieldShouldReturn(textField)
        if nextFeild != nil{
            nextFeild.field.becomeFirstResponder()
        }else{
            self.field.resignFirstResponder()
        }
        
        return returnValue
    }
}
