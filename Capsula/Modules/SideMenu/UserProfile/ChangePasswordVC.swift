//
//  ChangePasswordVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya

class ChangePasswordVC : UIViewController {
    
    @IBOutlet weak var oldPasswordField: CapsulaInputFeild!
    @IBOutlet weak var newPasswordField: CapsulaInputFeild!
    @IBOutlet weak var confirmPasswordField: CapsulaInputFeild!
    @IBOutlet weak var containerView :UIView!
    private let provider = MoyaProvider<UserDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 70
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func setFields(){
        oldPasswordField.type = .password
        newPasswordField.type = .newPassword
        confirmPasswordField.type = .confirmPassword
        oldPasswordField.setTextFeildSpecs()
        newPasswordField.setTextFeildSpecs()
        confirmPasswordField.setTextFeildSpecs()
    }
    
    
    func validate() -> Bool {
        var isValid = true
        isValid = oldPasswordField.validate() && isValid
        isValid = newPasswordField.validate() && isValid
        
        if confirmPasswordField.getText() != newPasswordField.getText() {
            isValid = false
            self.showMessage(Strings.shared.phoneMatched)
        }
        
        return isValid
    }
    
    
    
    @IBAction func savePressed(_ sender:  UIButton){
        
        if !validate(){
            return
        }
        changePassword()
    }
    
    
    func changePassword(){
        KVNProgress.show()
        provider.request(.changePassword(oldPasswordField.getText(), newPasswordField.getText())) { [weak self] result in
            guard let self = self else { return }
            KVNProgress.dismiss()
            switch result {
            case .success(_):
                self.showMessage(Strings.shared.resetPasswordSuccessMsg) {
                    self.dismiss(animated: true) {
                      
                    }
                }
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
