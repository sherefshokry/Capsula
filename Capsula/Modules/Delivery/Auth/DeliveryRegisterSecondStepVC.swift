//
//  DeliveryRegisterSecondStep.swift
//  Capsula
//
//  Created by SherifShokry on 6/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import SDWebImage
import Intercom

class DeliveryRegisterSecondStepVC : ImagePickerViewController  {
    
    var selectedBrandID = -1
    var selectedYearID = -1
    var selectedLicenceID = -1
    var selectedModelID = -1
    
    var registerRequest = DeliveryManRegisterRequest()
    var yearsList = [CarType]()
    var carBrandList = [CarType]()
    var licenceTypeList = [CarType]()
    var carModelList = [CarType]()
    var onFormCompleted : ((DeliveryManRegisterRequest) -> ())?
    
    @IBOutlet weak var  carBrandField : CapsulaInputFeild!
    @IBOutlet weak var  carModelField : CapsulaInputFeild!
    @IBOutlet weak var  carYearsField : CapsulaInputFeild!
    @IBOutlet weak var  carPlateNumberField : CapsulaInputFeild!
    @IBOutlet weak var  carPlateLettersField : CapsulaInputFeild!
    @IBOutlet weak var  carLicenceTypeField : CapsulaInputFeild!
    
    
    
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
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
    
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
        getRegistrationBasicData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
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
                self.carLicenceTypeField.setText(text: self.licenceTypeList[index].value ?? "")
                self.carLicenceTypeField.errorMsg = ""
            }
            picker.show()
        }
        
        
        
        
    }
    
    
    func getRegistrationBasicData(){
        KVNProgress.show()
        provider.request(.getRegistrationBasicData) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let basicDataResponse = try response.map(BaseResponse<DeliveryRegistrationDataResponse>.self)
                    
                    self.yearsList = basicDataResponse.data?.years ?? []
                    self.carBrandList = basicDataResponse.data?.carTypes ?? []
                    self.licenceTypeList = basicDataResponse.data?.vehicleTypes ?? []
                    
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
    
    
    
    @IBAction func nextPressed(_ sender : UIButton){
        
        
        if validate() {
            
            registerRequest.carTypeId = selectedBrandID
            registerRequest.carModelId = selectedModelID
            registerRequest.vehicleTypeId = selectedLicenceID
            registerRequest.yearId = selectedYearID
            registerRequest.vehiclePlateLetters = carPlateLettersField.getText()
            registerRequest.vehiclePlateNumber = Int(carPlateNumberField.getText()) ?? 0
            
            if onFormCompleted != nil {
                onFormCompleted!(registerRequest)
            }
            
            
        }
        
        
    }
    
    
}
