//
//  EditDeliveryProfileStep1VC.swift
//  Capsula
//
//  Created by SherifShokry on 8/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//


import UIKit
import Moya
import KVNProgress

class EditDeliveryProfileStep1VC : ImagePickerViewController  {
    
    var personalImage = ""
    var nationalitiesList = [Nationality]()
    var registerRequest = DeliveryRequest()
    var selectedNationalityID = -1
    var latitude = 0.0
    var longitude = 0.0
    @IBOutlet weak var  topView : UIView!
    @IBOutlet weak var  userImage : UIImageView!
    @IBOutlet weak var  citizenshipField : CapsulaInputFeild!
    @IBOutlet weak var  emailField : CapsulaInputFeild!
    @IBOutlet weak var  phoneField : CapsulaInputFeild!
    @IBOutlet weak var  addressField : CapsulaInputFeild!
    
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        loadCitizenshipData()
        setupInputFields()
        setUserData()
    }
    
    func fillUserRequest(user: DeliveryUser){
        
        registerRequest.email = user.email ?? ""
        registerRequest.phone = user.phoneNumber ?? ""
        registerRequest.vehiclePlateNumber = user.vehiclePlateNumber ?? -1
        registerRequest.vehiclePlateLetters = user.vehiclePlateLetters  ?? ""
        registerRequest.bankAccountNumber = user.bankAccountNumber ?? ""
        registerRequest.addressDesc = user.addressDesc ?? ""
        registerRequest.latitude = user.latitude ?? 0.0
        registerRequest.longitude = user.longitude ?? 0.0
        latitude = user.latitude ?? 0.0
        longitude = user.longitude ?? 0.0
        //   registerRequest.accountHolderAddress = user.bank ?? ""
        selectedNationalityID = user.nationalityId ?? -1
        registerRequest.nationalityId = user.nationalityId ?? -1
        registerRequest.carTypeId = user.carTypeId ?? -1
        registerRequest.carModelId = user.carModelId  ?? -1
        registerRequest.yearId  = user.yearId  ?? -1
        registerRequest.vehicleTypeId = user.vehicleTypeId  ?? -1
    }
    
    
    func loadCitizenshipData(){
        KVNProgress.show()
        provider.request(.getNationalities) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let nationalitiesResponse = try response.map(BaseResponse<NationalitiesResponse>.self)
                    
                    self.nationalitiesList = nationalitiesResponse.data?.nationalityList ?? []
                    
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
    
    
    
    func setUserData(){
        let user =  Utils.loadDeliveryUser()?.user ?? DeliveryUser()
        citizenshipField.field.text = user.nationalityDesc ?? ""
        emailField.field.text = user.email ?? ""
        phoneField.field.text = (user.phoneNumber ?? "")
        addressField.field.text = (user.addressDesc ?? "")
        userImage.sd_setImage(with: URL.init(string: user.personalPicture ?? "")
            , placeholderImage: UIImage(named : "icPersonal"))
        
        fillUserRequest(user: user)
        
    }
    
    func setupInputFields(){
        emailField.type = .email
        emailField.setTextFeildSpecs()
        phoneField.type = .phoneNumber
        phoneField.setTextFeildSpecs()
        citizenshipField.type = .action
        citizenshipField.setTextFeildSpecs()
        citizenshipField.titleLabel.text  =  Strings.shared.citizenship
        addressField.type = .action
        addressField.setTextFeildSpecs()
        addressField.titleLabel.text  =  Strings.shared.fullAddress
        
        citizenshipField.actionHandler = { _ in
            let picker = CustomPickerView()
            var options = [String]()
            self.nationalitiesList.forEach { (nationality) in
                options.append(nationality.value ?? "")
            }
            picker.selectedIndex = -1
            picker.titleText = Strings.shared.selectNationality
            picker.subTitleText = ""
            picker.listSource = options
            picker.doneSelectingAction = { index in
                self.selectedNationalityID = self.nationalitiesList[index].id ?? -1
                self.registerRequest.nationalityId = self.selectedNationalityID
                self.citizenshipField.setText(text: self.nationalitiesList[index].value ?? "")
                self.citizenshipField.errorMsg = ""
            }
            picker.show()
        }
        
        
        
        
        addressField.actionHandler = { _ in
            let vc = AddAddressViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
            vc.fromDeliveryMan = true
            vc.onAddAddressCompleted = { (fullAddress ,latitude ,longitude) in
                self.latitude = latitude
                self.longitude = longitude
                self.registerRequest.latitude = latitude
                self.registerRequest.longitude = longitude
                self.registerRequest.addressDesc = fullAddress
                self.addressField.setText(text: fullAddress)
                self.addressField.errorMsg = ""
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func validate() -> Bool {
        var isValid = true
        isValid = emailField.validate() && isValid
        isValid = citizenshipField.validate() && isValid
        isValid = addressField.validate() && isValid
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
    
    
    @IBAction func savePressed(_ sender : UIButton){
        
        if validate(){
            registerRequest.addressDesc = addressField.getText()
            registerRequest.nationalityId = selectedNationalityID
            registerRequest.email =  emailField.getText()
            registerRequest.phone = phoneField.getText()
            registerRequest.personalPicture =  personalImage
            registerRequest.latitude = latitude
            registerRequest.longitude = longitude
            updateDeliveryUserProfile(registerRequest: registerRequest)
        }

    }
    
    
    @IBAction func nextPressed(_ sender : UIButton){
        let vc =   EditDeliveryProfileStep2VC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
        vc.registerRequest = registerRequest
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func updateDeliveryUserProfile(registerRequest : DeliveryRequest){
        KVNProgress.show()
        provider.request(.updateDeliveryData(registerRequest)) { [weak self] result in
            guard let self = self else { return }
            KVNProgress.dismiss()
            switch result {
            case .success(let response):
                do {
                    let updatedDeliveryResponse = try response.map(BaseResponse<DeliveryUserResponse>.self).data ?? DeliveryUserResponse()
                    
                    var currentDeliveryResponse = Utils.loadDeliveryUser()
                    
                    currentDeliveryResponse?.user = updatedDeliveryResponse.user ?? DeliveryUser()
                    
                    Utils.saveDeliveryUser(user: currentDeliveryResponse)
                    
                    self.showMessage(Strings.shared.userProfileUpdatedMsg) {
                        self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: Notification.Name(Constants.REFRESH_DELIVERY_DATA), object: nil)
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
    
    
    
    
}
