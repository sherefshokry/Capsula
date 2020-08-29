//
//  RegisterViewController.swift
//  Capsula
//
//  Created SherifShokry on 12/25/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import KVNProgress
import Intercom
class RegisterViewController : UIViewController {
    
    var presenter : ViewToPresenterRegisterProtocol?
    @IBOutlet weak var emailField : CapsulaInputFeild!
    @IBOutlet weak var phoneField : CapsulaInputFeild!
    @IBOutlet weak var passwordField : CapsulaInputFeild!
    @IBOutlet weak var nameField : CapsulaInputFeild!
    private var state: State = .loading {
               didSet {
                   switch state {
                   case .ready:
                       KVNProgress.dismiss()
                   case .loading:
                         KVNProgress.show()
                   case .error(let error):
                       KVNProgress.dismiss()
                       self.showMessage(error)
                   }
               }
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         emailField.field.text = ""
         Intercom.setLauncherVisible(false)
    }
    
    func clearFields(){
           emailField.field.text = ""
           phoneField.field.text = ""
           nameField.field.text = ""
           passwordField.field.text = ""
           self.presenter?.clearRegisterRequest()
    }
    
    
    func setupInputFields(){
        emailField.type = .email
        emailField.setTextFeildSpecs()
        phoneField.type = .phoneNumber
        phoneField.setTextFeildSpecs()
        passwordField.type = .password
        passwordField.setTextFeildSpecs()
        nameField.type = .name
        nameField.setTextFeildSpecs()
    }
    
    
    func validate() -> Bool {
        var isValid = true
        isValid = emailField.validate() && isValid
        isValid = nameField.validate() && isValid
        isValid = passwordField.validate() && isValid
        isValid = phoneField.validate() && isValid
        return isValid
    }

    @IBAction func registerPressed(_ sender : UIButton){
        
        if !validate() {
            return
        }
        
        
        self.presenter?.setNameField(name : nameField.getText())
        self.presenter?.setPhoneFiled(phone: phoneField.getText())
        self.presenter?.setEmailField(email: emailField.getText())
        self.presenter?.setPasswordField(password: passwordField.getText())
        self.presenter?.checkIfPhoneExist(phone: phoneField.getText())

        
    }
    
    
    @IBAction func facebookPressed(_ sender : UIButton){
        NotificationCenter.default.post(name: Notification.Name(Constants.FACEBOOK_NOTIFICATION), object: nil, userInfo: nil)
    }
    
    
    @IBAction func gmailPressed(_ sender : UIButton){
        NotificationCenter.default.post(name: Notification.Name(Constants.GOOGLE_NOTIFICATION), object: nil, userInfo: nil)
     }
    
    
    @IBAction func twitterPressed(_ sender : UIButton){
        NotificationCenter.default.post(name: Notification.Name(Constants.TWITTER_NOTIFICATION), object: nil, userInfo: nil)
    }
    
    
    
}
extension RegisterViewController : PresenterToViewRegisterProtocol {
    func changeState(state: State) {
        self.state = state
    }
    
    
    
}
