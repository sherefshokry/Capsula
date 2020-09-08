//
//  EditDeliveryProfileStep2VC.swift
//  Capsula
//
//  Created by SherifShokry on 8/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Moya
import KVNProgress


class EditDeliveryProfileStep2VC : UIViewController {
    
    var registerRequest = DeliveryRequest()
    var selectedBrandID = -1
    var selectedYearID = -1
    var selectedLicenceID = -1
    var selectedModelID = -1
    var yearsList = [CarType]()
    var carBrandList = [CarType]()
    var licenceTypeList = [CarType]()
    var carModelList = [CarType]()
    var onFormCompleted : ((DeliveryManRegisterRequest) -> ())?
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    @IBOutlet weak var  topView : UIView!
    @IBOutlet weak var  carBrandField : CapsulaInputFeild!
    @IBOutlet weak var  carModelField : CapsulaInputFeild!
    @IBOutlet weak var  carYearsField : CapsulaInputFeild!
    @IBOutlet weak var  carPlateNumberField : CapsulaInputFeild!
    @IBOutlet weak var  carPlateLettersField : CapsulaInputFeild!
    @IBOutlet weak var  carLicenceTypeField : CapsulaInputFeild!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupInputFields()
        setUserData()
        getRegistrationBasicData()
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    func setUserData(){
        let user =  Utils.loadDeliveryUser()?.user ?? DeliveryUser()
        carPlateNumberField.field.text = "\(user.vehiclePlateNumber ?? -1)"
        carPlateLettersField.field.text = user.vehiclePlateLetters ?? ""
        carLicenceTypeField.field.text = user.vehicleTypeDesc ?? ""
        carYearsField.field.text = user.yearDesc ?? ""
        carModelField .field.text = user.carModelDesc ?? ""
        carBrandField.field.text  = user.carTypeDesc ?? ""
        selectedBrandID = user.carTypeId ?? -1
        selectedYearID =  user.yearId ?? -1
        selectedLicenceID = user.vehicleTypeId ?? -1
        selectedModelID = user.carModelId ?? -1
    }
    
    
    
    func setupInputFields(){
        
        carBrandField.type = .action
        carBrandField.setTextFeildSpecs()
        carBrandField.titleLabel.text = Strings.shared.carBrand
        
        carModelField.type = .action
        carModelField.setTextFeildSpecs()
        carModelField.titleLabel.text = Strings.shared.carModel
        
        carYearsField.type = .action
        carYearsField.setTextFeildSpecs()
        carYearsField.titleLabel.text = Strings.shared.modelYear
        
        carLicenceTypeField.type = .action
        carLicenceTypeField.setTextFeildSpecs()
        carLicenceTypeField.titleLabel.text = Strings.shared.licenceType
        
        
        carPlateNumberField.type = .regular
        carPlateNumberField.setTextFeildSpecs()
        carPlateNumberField.field.keyboardType = .asciiCapableNumberPad
        carPlateNumberField.titleLabel.text = ""
        carPlateNumberField.feildPlaceHolder = Strings.shared.plateNumber
        
        carPlateLettersField.type = .regular
        carPlateLettersField.setTextFeildSpecs()
        carPlateLettersField.titleLabel.text = ""
        carPlateLettersField.feildPlaceHolder = Strings.shared.plateLetters
        
        
        
        
        carBrandField.actionHandler = { _ in
            
            let picker = CustomPickerView()
            var options = [String]()
            self.carBrandList.forEach { (brand) in
                options.append(brand.value ?? "")
            }
            
            if let index = self.carBrandList.firstIndex(where: { (item) -> Bool in
                item.id  ==  self.selectedBrandID
                // test if this is the item you're looking for
            }){
                picker.selectedIndex = index
            }else{
                picker.selectedIndex = -1
            }
            picker.titleText = Strings.shared.selectBrand
            picker.subTitleText = ""
            picker.listSource = options
            picker.doneSelectingAction = { index in
                self.selectedBrandID = self.carBrandList[index].id ?? -1
                self.registerRequest.carTypeId = self.carBrandList[index].id ?? -1
                self.carBrandField.setText(text: self.carBrandList[index].value ?? "")
                self.carBrandField.errorMsg = ""
                self.getCarModels()
            }
            picker.show()
        }
        
        
        
        
        //Select Car Model
        carModelField.actionHandler = { _ in
            if self.selectedBrandID == -1 {
                self.showMessage(Strings.shared.pickBrandFirst)
            }
            else{
                let picker = CustomPickerView()
                var options = [String]()
                self.carModelList.forEach { (model) in
                    options.append(model.value ?? "")
                }
                if let index = self.carModelList.firstIndex(where: { (item) -> Bool in
                    item.id  ==  self.selectedModelID
                    // test if this is the item you're looking for
                }){
                    picker.selectedIndex = index
                }else{
                    picker.selectedIndex = -1
                }
                picker.titleText = Strings.shared.selectModel
                picker.subTitleText = ""
                picker.listSource = options
                picker.doneSelectingAction = { index in
                    self.selectedModelID = self.carModelList[index].id ?? -1
                    self.registerRequest.carModelId = self.carModelList[index].id ?? -1
                    self.carModelField.setText(text: self.carModelList[index].value ?? "")
                    self.carModelField.errorMsg = ""
                }
                picker.show()
            }
        }
        
        //car model year
        carYearsField.actionHandler = { _ in
            let picker = CustomPickerView()
            var options = [String]()
            self.yearsList.forEach { (year) in
                options.append(year.value ?? "")
            }
            if let index = self.yearsList.firstIndex(where: { (item) -> Bool in
                item.id  ==  self.selectedYearID
                // test if this is the item you're looking for
            }){
                picker.selectedIndex = index
            }else{
                picker.selectedIndex = -1
            }
            picker.titleText = Strings.shared.selectYear
            picker.subTitleText = ""
            picker.listSource = options
            picker.doneSelectingAction = { index in
                self.selectedYearID = self.yearsList[index].id ?? -1
                self.registerRequest.yearId = self.yearsList[index].id ?? -1
                self.carYearsField.setText(text: self.yearsList[index].value ?? "")
                self.carYearsField.errorMsg = ""
            }
            picker.show()
        }
        
        
        //car Licence Type
        carLicenceTypeField.actionHandler = { _ in
            let picker = CustomPickerView()
            var options = [String]()
            self.licenceTypeList.forEach { (licence) in
                options.append(licence.value ?? "")
            }
            if let index = self.licenceTypeList.firstIndex(where: { (item) -> Bool in
                item.id  ==  self.selectedLicenceID
                // test if this is the item you're looking for
            }){
                picker.selectedIndex = index
            }else{
                picker.selectedIndex = -1
            }
            picker.titleText = Strings.shared.selectLicence
            picker.subTitleText = ""
            picker.listSource = options
            picker.doneSelectingAction = { index in
                self.selectedLicenceID = self.licenceTypeList[index].id ?? -1
                self.registerRequest.vehicleTypeId = self.licenceTypeList[index].id ?? -1
                self.carLicenceTypeField.setText(text: self.licenceTypeList[index].value ?? "")
                self.carLicenceTypeField.errorMsg = ""
            }
            picker.show()
        }
        
    }
    
    
    func getRegistrationBasicData(){
        KVNProgress.show()
        provider.request(.getRegistrationBasicData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let basicDataResponse = try response.map(BaseResponse<DeliveryRegistrationDataResponse>.self)
                    
                    self.yearsList = basicDataResponse.data?.years ?? []
                    self.carBrandList = basicDataResponse.data?.carTypes ?? []
                    self.licenceTypeList = basicDataResponse.data?.vehicleTypes ?? []
                    self.getCarModels()
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
    
    
    func getCarModels(){
        
        KVNProgress.show()
        provider.request(.getCarModels(selectedBrandID)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let modelResponse = try response.map(BaseResponse<CarModelResponse>.self)
                    
                    self.carModelList = modelResponse.data?.modelsList ?? []
                    
                    
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
    
    
    func validate() -> Bool {
        var isValid = true
        isValid = carBrandField.validate() && isValid
        isValid = carModelField.validate() && isValid
        isValid = carYearsField.validate() && isValid
        isValid = carPlateNumberField.validate() && isValid
        isValid = carPlateLettersField.validate() && isValid
        isValid = carLicenceTypeField.validate() && isValid
        return isValid
    }
    
    
    
    @IBAction func savePressed(_ sender : UIButton){
        
        if validate(){
            registerRequest.vehicleTypeId = selectedLicenceID
            registerRequest.carModelId = selectedModelID
            registerRequest.yearId = selectedYearID
            registerRequest.carTypeId = selectedBrandID
            registerRequest.vehiclePlateLetters  = carPlateLettersField.getText()
            registerRequest.vehiclePlateNumber = Int(carPlateNumberField.getText()) ?? 0
            
            updateDeliveryUserProfile(registerRequest: registerRequest)
        }
    }
    
    @IBAction func nextPressed(_ sender : UIButton){
        let vc =   EditDeliveryProfileStep3VC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
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
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true
                            , completion: {
                                
                             NotificationCenter.default.post(name: Notification.Name(Constants.REFRESH_DELIVERY_DATA), object: nil)
                                
                        })
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
