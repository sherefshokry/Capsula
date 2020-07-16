//
//  LoginDeliveryViewController.swift
//  Capsula
//
//  Created by SherifShokry on 6/5/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import Intercom


class LoginDeliveryViewController : UIViewController {
    
    @IBOutlet weak var emailField : CapsulaInputFeild!
    @IBOutlet weak var passwordField : CapsulaInputFeild!
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.field.text = ""
        passwordField.field.text = ""
        Intercom.setLauncherVisible(false)
    }
    
    func setupInputFields(){
        emailField.type = .phoneOrEmail
        passwordField.type = .number
        emailField.setTextFeildSpecs()
        passwordField.setTextFeildSpecs()
    }
    
    
    
    func validate() -> Bool {
        var isValid = true
        
        isValid = emailField.validate() && isValid
        isValid = passwordField.validate() && isValid
        
        return isValid
    }
    
    
    @IBAction func  loginPressed(_ sender : UIButton){
        
        if !validate(){
            return
        }
        
        let loginRequest = LoginRequest()
        loginRequest.phoneOrEmail = emailField.getText()
        loginRequest.password = passwordField.getText()
        KVNProgress.show()
        provider.request(.deliveryManLogin(loginRequest)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let userResponse = try response.map(BaseResponse<DeliveryUserResponse>.self).data ?? DeliveryUserResponse()
                    Utils.saveDeliveryUser(user: userResponse)
                    UserDefaults.standard.set(true, forKey: "isDelivery")
                    Utils.openDeliveryHomeScreen()
               } catch(let catchError) {
                    self.showMessage(catchError.localizedDescription)
                }
                break
            case .failure(let error):
                do{
                    if let body = try error.response?.mapJSON(){
                        let errorData = (body as! [String:Any])
                        
                        self.showMessage((errorData["errors"] as? String) ?? "")
                        
                    }
                }catch{
                    self.showMessage(error.localizedDescription)
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    
}
