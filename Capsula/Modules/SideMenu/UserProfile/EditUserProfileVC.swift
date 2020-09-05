//
//  EditUserProfileVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import Moya
import KVNProgress
import ContentSheet


class EditUserProfileVC : ImagePickerViewController {
    
    var personalImage = ""
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var  userImage : UIImageView!
    @IBOutlet weak var  nameField : CapsulaInputFeild!
    @IBOutlet weak var  emailField : CapsulaInputFeild!
    @IBOutlet weak var  phoneField : CapsulaInputFeild!
    @IBOutlet weak var  addressField : CapsulaInputFeild!
    @IBOutlet weak var  changePasswordBtn : UIButton!
    
    private let provider = MoyaProvider<UserDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
        setUserData()
    }
    
    func setUserData(){
        let user =  Utils.loadUser()?.user ?? User()
        nameField.field.text = user.name ?? ""
        emailField.field.text = user.email ?? ""
        phoneField.field.text = (user.phone ?? "")
        addressField.field.text = user.defaultAddress?.addressDesc ?? ""
        userImage.sd_setImage(with: URL.init(string: user.photo ?? "")
            , placeholderImage: UIImage(named : "icPersonal"))
      
    }
    
    func setupInputFields(){
        emailField.type = .email
        emailField.setTextFeildSpecs()
        phoneField.type = .phoneNumber
        phoneField.setTextFeildSpecs()
        nameField.type = .name
        nameField.setTextFeildSpecs()
        addressField.titleLabel.text  =  Strings.shared.currentLocation
        addressField.type = .action
        addressField.setTextFeildSpecs()
        
        addressField.actionHandler = { _ in
            
             let content: ContentSheetContentProtocol
                let vc = AddressListViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
                
                vc.refreshCheckoutAddress = {
                    self.setDefaultAddress()
                }
                let contentController = vc
                content = contentController
                let contentSheet = ContentSheet(content: content)
                contentSheet.blurBackground = false
                contentSheet.showDefaultHeader = false
                UIApplication.shared.windows[0].visibleViewController?.present( contentSheet, animated: true, completion: nil)
            
        }
        
        
    }
    
    func setDefaultAddress(){
           let userDefaultAddress = Utils.loadUser().user?.defaultAddress ?? Address()
        addressField.field.text = userDefaultAddress.addressDesc ?? ""
        NotificationCenter.default.post(name: Notification.Name(Constants.REFRESH_USER_DATA), object: nil)
       }
    
    
    func validate() -> Bool {
        var isValid = true
        isValid = emailField.validate() && isValid
        isValid = nameField.validate() && isValid
        isValid = phoneField.validate() && isValid
        return isValid
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    
    
    @IBAction func editUserImage(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.userImage.image = imge
            self.personalImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    
    @IBAction func donePressed(_ sender : UIButton){
        
        
        if validate(){
            let registerRequest = RegisterRequest()
            registerRequest.name = nameField.getText()
            registerRequest.email =  emailField.getText()
            registerRequest.phone = phoneField.getText()
            registerRequest.image =  personalImage
            updateUserProfile(registerRequest: registerRequest)
        }
        
    }
    
    
    
    func updateUserProfile(registerRequest : RegisterRequest){
        KVNProgress.show()
        provider.request(.updateUser(registerRequest)) { [weak self] result in
            guard let self = self else { return }
            KVNProgress.dismiss()
            switch result {
            case .success(let response):
                
                do {
                    let updatedUserResponse = try response.map(BaseResponse<UserResponse>.self).data ?? UserResponse()
                    
                    var currentUserResponse = Utils.loadUser()
                    
                    currentUserResponse?.user = updatedUserResponse.user ?? User()
                    Utils.saveUser(user: currentUserResponse)
                    
                    
                    self.showMessage(Strings.shared.userProfileUpdatedMsg) {
                        self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: Notification.Name(Constants.REFRESH_USER_DATA), object: nil)
                        }
                    }
                    
                } catch(let catchError) {
                    self.showMessage(catchError.localizedDescription)
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
    
    @IBAction func changePasswordPressed(_ sender : UIButton){
        let vc = ChangePasswordVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
