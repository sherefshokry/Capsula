//
//  inputField.swift
//  Shezlong
//
//  Created by George Naiem on 8/6/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//
import UIKit

protocol InputFeildDelegate {
    func shouldBeginEditing(inputFeild : InputField)
    func didEndEditing(inputFeild : InputField)
    func didBeginEditing(inputFeild : InputField)
    func shouldReturn(inputFeild : InputField)
    func edittingChanged(inputFeild : InputField)
}

class InputField: BaseNibLoader  {
    
    public enum feildType : String{
        case phoneOrEmail = "phoneOrEmail"
        case email = "email"
        case password = "password"
        case phoneNumber = "phoneNumber"
        case number = "number"
        case confirmPassword = "confirm password"
        case newPassword = "new password"
        case regular = "regular"
        case name = "name"
        case action = "action"
        case no = "no"
        case VinNo = "VinNo"
        case PlateNo = "PlateNo"
        case age = "age"
        case notRequired = "notRequired"
        case eyePassword = "eyePassword"
        case eyePasswordNoValidation = "eyePasswordNoValidation"
    }
    
    @IBOutlet weak var eyeButton: UIButton!
    @IBAction func eyeButtonPressed(_ sender: Any) {
        field.isSecureTextEntry = !field.isSecureTextEntry
        
        if !field.isSecureTextEntry{
            eyeButton.setImage(UIImage(named: "ic_show"), for: .normal)
        }else{
            eyeButton.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
    @IBOutlet weak var numberViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var actionBtn : UIButton!
    @IBOutlet weak var eyeView : UIView!
    @IBOutlet weak var verticalLineView : UIView!
    @IBOutlet weak var lineView : UIView!
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    
    func setImage(imageName : String){
        sideImage.image = UIImage(named: imageName)
    }
    
    var actionHandler: ((Any)->Void)?
    var type : feildType = .regular {
        didSet{
            if actionBtn != nil
            {
                actionBtn.isHidden = self.type != .action
                
            }
        }
    }
    
    var delegate : InputFeildDelegate!
    var optional = false
    
    
    @IBInspectable var errorMsg = ""{
        didSet{
            
            errorLabel.text = errorMsg
        }
    }
    @IBInspectable  var feildPlaceHolder : String = ""{
        didSet{
            field.placeholder = feildPlaceHolder
        }
    }
    
    func setLineColor(color : UIColor){
        lineView.borderColor = color
    }
    
    @IBAction func buttonPressed(_ sender : Any){
        if actionHandler != nil{
            actionHandler!(sender)
        }
    }
    
    
    // var textColor = UIColor.
    
    
    func reSet(){
        setText(text: "")
        field.leftView = UIView()
        normal()
    }
    
    override func awakeFromNib() {
        numberView.semanticContentAttribute = .forceLeftToRight
        
        if appIsArabic(){
            field.textAlignment = .right
        }
        // textColor = field.textColor!
        field.delegate = self
        self.field.addTarget(self, action: #selector(textFeildChanged), for: .editingChanged)
        self.normal()
    }
    
    func invalid(error: String) {
        field.isEnabled = true
        errorLabel.text = error
        errorLabel.isHidden = false
        errorLabel.textColor = UIColor.red
    }
    
    func dim() {
        field.isEnabled = false
    }
    
    func normal() {
        field.isEnabled = true
        //  field.textColor = textColor
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
    func getText() -> String {
        return field.text!
    }
    func setText(text: String){
        field.text = text
    }
    
    func isEmptyAndNotOptional()->Bool{
        return self.getText().trim().isEmpty && !optional
    }
    
    
    func validate()->Bool{
        var isValid = true
        switch type {
        case .eyePassword:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password_Empty", comment: ""))
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPassword(text: self.getText()) {
                        isValid = false
                        self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password_Validation", comment: ""))
                    }
                }
            }
            break
            
        case .eyePasswordNoValidation:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Password_Empty", comment: ""))
            }
            break
        case .PlateNo:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Plate_Empty", comment: ""))
            }else{
                if !optional || (optional && getText().trim() != ""){
                    
                    if getText().count > 7 || getText().count < 5{
                        isValid = false
                        self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Plate_Validation", comment: ""))
                    }
                }
            }
            break
        case .VinNo:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Vin_Empty", comment: ""))
            }else{
                if !optional || (optional && getText().trim() != ""){
                    
                    if getText().count != 17 {
                        isValid = false
                        self.invalid(error: LocalizationSystem.sharedInstance.localizedStringForKey(key: "Vin_Validation", comment: ""))
                    }
                }
            }
            break
        case  .no:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: Strings.Validation.shared.generalFieldValidation)
            }
            break
        case .action:
            if isEmptyAndNotOptional(){
                isValid = false
                let fieldTitle = (titleLabel.text ?? "").lowercased()
        let editedTitle = fieldTitle.replacingOccurrences(of: "*", with: "")
            let errorMsg = Strings.Validation.shared.dropDownValidation + editedTitle
                self.invalid(error: errorMsg)
            }else{
                
            }
            break
        case .email:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: Strings.Validation.shared.mailValidation)
            }else if !optional || (optional && getText().trim() != ""){
                if !Validations.isValidEmail(text: self.getText().trim()){
                    isValid = false
                    self.invalid(error: Strings.Validation.shared.mailValidation)
                }
            }
            break
        case .age:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (errorMsg != "") ?
                    errorMsg : "Field can't be empty".localize())
            }
            break
        case .password:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: Strings.Validation.shared.passwordEmpty)
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPassword(text: self.getText()) {
                        isValid = false
                        self.invalid(error: Strings.Validation.shared.passwordPolicyValidation)
                    }
                }
            }
            break
        case .phoneNumber:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: Strings.Validation.shared.phoneValidation)
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPhoneNumber(text: self.getText().trim()) {
                        isValid = false
                        self.invalid(error: Strings.Validation.shared.phoneValidation)
                    }
                }
            }
            break
        case .number:
            if isEmptyAndNotOptional(){
                isValid = false
                let editedTitle = titleLabel.text?.replacingOccurrences(of: "*", with: "").lowercased() ?? ""
                let errorMsg = Strings.Validation.shared.fieldValidation + editedTitle
                self.invalid(error: errorMsg)
            }
            break
        case .name:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (errorMsg != "") ?
                    errorMsg : Strings.Validation.shared.nameValidation)
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidName(string: self.getText()) {
                        isValid = false
                        self.invalid(error: Strings.Validation.shared.nameValidation)
                    }
                }
                
                
            }
            break
        case .regular:
            if isEmptyAndNotOptional(){
                isValid = false
                let editedTitle = titleLabel.text?.replacingOccurrences(of: "*", with: "").lowercased() ?? ""
                let errorMsg = Strings.Validation.shared.fieldValidation + editedTitle
                self.invalid(error: errorMsg)
            }
            break
        case .notRequired:
            break
      
        case .confirmPassword:
            if isEmptyAndNotOptional(){
                isValid = false
                let editedTitle = field.placeholder?.replacingOccurrences(of: "*", with: "").lowercased() ?? ""
                let errorMsg = Strings.Validation.shared.fieldValidation + editedTitle
                self.invalid(error: errorMsg)
            }

        case .newPassword:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: Strings.Validation.shared.passwordEmpty)
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPassword(text: self.getText()) {
                        isValid = false
                        self.invalid(error: Strings.Validation.shared.passwordPolicyValidation)
                    }
                }
            }
        case .phoneOrEmail:
            if isEmptyAndNotOptional(){
                isValid = false
                let editedTitle = titleLabel.text?.replacingOccurrences(of: "*", with: "").lowercased() ?? ""
                let errorMsg = Strings.Validation.shared.fieldValidation + editedTitle
                self.invalid(error: errorMsg)
                       }
        }
        return isValid
    }
}

extension InputField : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil{
            delegate.didBeginEditing(inputFeild: self)
        }
        self.normal()
        // setLineColor(color: Colors.appPrimeryColor)
    }
    
    @objc func textFeildChanged(_ sender : UITextField){
        if delegate != nil{
            delegate.edittingChanged(inputFeild: self)
        }
        if type != .password{
            setText(text: getText().updateToEngNum())
        }
        //        setLineColor(color: Colors.appPrimeryColor)
  
 
        let status = validate()
        
        if status {
            invalid(error: "")
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldBeginEditing(inputFeild: self)
        }
        self.normal()
        //        setLineColor(color: Colors.appPrimeryColor)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldReturn(inputFeild: self)
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if delegate != nil{
            delegate.didEndEditing(inputFeild: self)
        }
        //   setLineColor(color: Colors.textFeildLineColor)
        let _ = validate()
    }
}
