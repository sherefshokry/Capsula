//
//  DeliveryRegisterThirdStep.swift
//  Capsula
//
//  Created by SherifShokry on 6/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import SDWebImage
import Alamofire
import Intercom


class DeliveryRegisterThirdStepVC : ImagePickerViewController  {
    
    
    var licenceImage = ""
    var idImage = ""
    var frontImage = ""
    var backImage = ""
    var registrationImage = ""
    var isTermsChecked = false
    var registerRequest = DeliveryManRegisterRequest()
    @IBOutlet weak var carLicenceImage : UIImageView!
    @IBOutlet weak var nationalIDImage : UIImageView!
    @IBOutlet weak var carFrontImage : UIImageView!
    @IBOutlet weak var carBackImage : UIImageView!
    @IBOutlet weak var carRegistrationImage : UIImageView!
    @IBOutlet weak var checkTermsBtn : UIButton!
    @IBOutlet weak var TermsAndConditionBtn : UIButton!
    @IBOutlet weak var licenceErrorLabel : UILabel!
    @IBOutlet weak var idErrorLabel : UILabel!
    @IBOutlet weak var carFrontErrorLabel : UILabel!
    @IBOutlet weak var carBackErrorLabel : UILabel!
    @IBOutlet weak var carRegisterationErrorLabel : UILabel!
    @IBOutlet weak var termsErrorLabel: UILabel! 
    
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
        TermsAndConditionBtn.setUnderLineText(text: Strings.shared.termsAndConditons)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    @IBAction func pickCarLicencePhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carLicenceImage.image = imge
            self.licenceImage = imge.toBase64() ?? ""
            self.licenceErrorLabel.text = ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
    }
    
    @IBAction func pickNationalIDPhoto(_ sender : UIButton){
        self.completion = { (imge , imgeString) in
            self.nationalIDImage.image = imge
            self.idImage = imge.toBase64() ?? ""
            self.idErrorLabel.text = ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    @IBAction func pickCarFrontPhoto(_ sender : UIButton){
        
        
        self.completion = { (imge , imgeString) in
            self.carFrontImage.image = imge
            self.frontImage = imge.toBase64() ?? ""
            self.carFrontErrorLabel.text = ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    @IBAction func pickCarBackPhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carBackImage.image = imge
            self.backImage = imge.toBase64() ?? ""
            self.carBackErrorLabel.text = ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
        
    }
    
    
    @IBAction func pickCarRegistrationPhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carRegistrationImage.image = imge
            self.registrationImage = imge.toBase64() ?? ""
            self.carRegisterationErrorLabel.text = ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
        
    }
    
    
    @IBAction func openTermsAndConditionsScreen(_ sender : UIButton){
        
        let vc = TermsAndConditionVC.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func checkTermsAndConditionPressed(_ sender : UIButton){
        
        if !isTermsChecked {
            checkTermsBtn.setImage(UIImage(named: "icChecked"), for: .normal)
            isTermsChecked = true
            termsErrorLabel.text = ""
        }else{
            checkTermsBtn.setImage(UIImage(named: "icUnchecked"), for: .normal)
            isTermsChecked = false
            
        }
        
    }
    
    
    
    @IBAction func sumbitPressed(_ sender : UIButton){
        
        var isValid = true
        if !isTermsChecked {
            termsErrorLabel.text = Strings.shared.privacyPolicyErrorMsg
            isValid = false
        }
        
        if licenceImage == "" {
            isValid = false
            licenceErrorLabel.text = Strings.shared.requiredField
        }
        
        if idImage ==  "" {
            isValid = false
            idErrorLabel.text = Strings.shared.requiredField
        }
        
        if frontImage == "" {
            isValid = false
            carFrontErrorLabel.text = Strings.shared.requiredField
        }
        
        if backImage == "" {
            isValid = false
            carBackErrorLabel.text = Strings.shared.requiredField
        }
        
        if registrationImage == "" {
            isValid = false
            carRegisterationErrorLabel.text = Strings.shared.requiredField
        }
        
        if isValid {
            //Call Delivery Registration Api
            registerRequest.carFromFrontPicture = frontImage
            registerRequest.carFromBehindPicture = backImage
            registerRequest.carRegistrationPicture = registrationImage
            registerRequest.idCardPicture = idImage
            registerRequest.driverLicensePicture = licenceImage
            callRegisterApi()
        }
    }
    
    
    
    func callRegisterApi(){
        KVNProgress.show()
        provider.request(.deliveryManRegister(registerRequest)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                
                do {
                    let successMsg = try response.map(BaseResponse<String>.self)
                    self.showMessage(successMsg.data ?? Strings.shared.deliveryRegistrationSuccess) {
                        Utils.openLoginScreen(isDeliveryMan: true)
                    }
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
