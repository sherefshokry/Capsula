//
//  DeliveryRegisterFirstStepVC.swift
//  Capsula
//
//  Created by SherifShokry on 6/7/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import SDWebImage
import Intercom

class DeliveryRegisterFirstStepVC : ImagePickerViewController  {
    
    var personalImage = ""
    var latitude = 0.0
    var longitude = 0.0
    var registerRequest = DeliveryManRegisterRequest()
    var selectedNationalityID = -1
    var nationalitiesList = [Nationality]()
    @IBOutlet weak var nameField : CapsulaInputFeild!
    @IBOutlet weak var emailField : CapsulaInputFeild!
    @IBOutlet weak var phoneField : CapsulaInputFeild!
    @IBOutlet weak var citizenShipField : CapsulaInputFeild!
    @IBOutlet weak var nationalIDField : CapsulaInputFeild!
    @IBOutlet weak var bankAccountField : CapsulaInputFeild!
    @IBOutlet weak var fullAddressField : CapsulaInputFeild!
    @IBOutlet weak var profileImage : UIImageView!
    var onFormCompleted : ((DeliveryManRegisterRequest) -> ())?
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
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
    
    
    func setupInputFields(){
        
        nameField.type = .name
        nameField.setTextFeildSpecs()
        emailField.type = .email
        emailField.setTextFeildSpecs()
        phoneField.type = .phoneNumber
        phoneField.setTextFeildSpecs()
        citizenShipField.type = .action
        citizenShipField.setTextFeildSpecs()
        nationalIDField.type = .regular
        nationalIDField.setTextFeildSpecs()
        nationalIDField.field.keyboardType = .asciiCapableNumberPad
        bankAccountField.type = .regular
        bankAccountField.setTextFeildSpecs()
        fullAddressField.type = .action
        fullAddressField.setTextFeildSpecs()
        citizenShipField.titleLabel.text  =  Strings.citizenship
        nationalIDField.titleLabel.text  =  Strings.nationalID
        bankAccountField.titleLabel.text  =  Strings.bankAccount
        fullAddressField.titleLabel.text  =  Strings.fullAddress
        
        
        
        citizenShipField.actionHandler = { _ in
            
            let picker = CustomPickerView()
            var options = [String]()
            self.nationalitiesList.forEach { (nationality) in
                options.append(nationality.value ?? "")
            }
            picker.selectedIndex = -1
            picker.titleText = Strings.selectNationality
            picker.subTitleText = ""
            picker.listSource = options
            picker.doneSelectingAction = { index in
                self.selectedNationalityID = self.nationalitiesList[index].id ?? -1
                self.citizenShipField.setText(text: self.nationalitiesList[index].value ?? "")
                self.citizenShipField.errorMsg = ""
            }
            picker.show()
        }
        
        
        
        
        fullAddressField.actionHandler = { _ in
            
            let vc = AddAddressViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
            vc.fromDeliveryMan = true
            vc.onAddAddressCompleted = { (fullAddress ,latitude ,longitude) in
                self.latitude = latitude
                self.longitude = longitude
                self.fullAddressField.setText(text: fullAddress)
                self.fullAddressField.errorMsg = ""
            }
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    func validate() -> Bool {
        var isValid = true
        isValid = emailField.validate() && isValid
        isValid = nameField.validate() && isValid
        isValid = phoneField.validate() && isValid
        isValid = citizenShipField.validate() && isValid
        isValid = fullAddressField.validate() && isValid
        isValid = nationalIDField.validate() && isValid
        
        do {
            let _ = try ValidateSAID.check(nationalIDField.getText())
            // this will print NationaltyType description
            nationalIDField.errorMsg = ""
        } catch {
            isValid = false
            nationalIDField.errorMsg = Strings.nationalIDValidation
        }
        
        return isValid
    }
    
    @IBAction func changePhotoPressed(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.profileImage.image = imge
            self.personalImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.chooseOption)
    }
    
    
    
    @IBAction func nextPressed(_ sender:  UIButton){
        
        
        if validate() {
            
            
            registerRequest.name = nameField.getText()
            registerRequest.phone = phoneField.getText()
            registerRequest.email = emailField.getText()
            registerRequest.imageUrl = personalImage
            registerRequest.latitude = latitude
            registerRequest.longitude = longitude
            registerRequest.addressDesc = fullAddressField.getText()
            registerRequest.nationalID = nationalIDField.getText()
            registerRequest.nationalityId = selectedNationalityID
            registerRequest.bankAccount = bankAccountField.getText()
            
            if onFormCompleted != nil {
                onFormCompleted!(registerRequest)
            }
            
        }
        
        
    }
    
}
