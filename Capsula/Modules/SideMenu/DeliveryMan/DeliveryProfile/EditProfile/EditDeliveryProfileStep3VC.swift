//
//  EditDeliveryProfileStep3VC.swift
//  Capsula
//
//  Created by SherifShokry on 8/27/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//2
import UIKit
import Moya
import KVNProgress

class EditDeliveryProfileStep3VC : ImagePickerViewController{
    
    var registerRequest = DeliveryRequest()
    var licenceImage = ""
    var idImage = ""
    var frontImage = ""
    var backImage = ""
    var registrationImage = ""
    
    @IBOutlet weak var  topView : UIView!
    @IBOutlet weak var carLicenceImage : UIImageView!
    @IBOutlet weak var nationalIDImage : UIImageView!
    @IBOutlet weak var carFrontImage : UIImageView!
    @IBOutlet weak var carBackImage : UIImageView!
    @IBOutlet weak var carRegistrationImage : UIImageView!

    
    
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUserData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    func setUserData(){
        let user =  Utils.loadDeliveryUser()?.user ?? DeliveryUser()
        carLicenceImage.sd_setImage(with: URL.init(string: user.driverLicensePicture ?? "") , placeholderImage: nil)
        nationalIDImage.sd_setImage(with: URL.init(string: user.idCardPicture ?? "") , placeholderImage: nil)
        carFrontImage.sd_setImage(with: URL.init(string: user.carFromFrontPicture ?? "") , placeholderImage: nil)
        carBackImage.sd_setImage(with: URL.init(string: user.carFromBehindPicture ?? "") , placeholderImage: nil)
        carRegistrationImage.sd_setImage(with: URL.init(string: user.carRegistrationPicture ?? "") , placeholderImage: nil)
    }
    
    
    @IBAction func pickCarLicencePhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carLicenceImage.image = imge
            self.licenceImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
    }
    
    @IBAction func pickNationalIDPhoto(_ sender : UIButton){
        self.completion = { (imge , imgeString) in
            self.nationalIDImage.image = imge
            self.idImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    @IBAction func pickCarFrontPhoto(_ sender : UIButton){
        
        
        self.completion = { (imge , imgeString) in
            self.carFrontImage.image = imge
            self.frontImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    @IBAction func pickCarBackPhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carBackImage.image = imge
            self.backImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
        
    }
    
    
    @IBAction func pickCarRegistrationPhoto(_ sender : UIButton){
        
        self.completion = { (imge , imgeString) in
            self.carRegistrationImage.image = imge
            self.registrationImage = imge.toBase64() ?? ""
            self.completion = nil
        }
        self.openUploadImageBottomSheet(withTitle: Strings.shared.chooseOption)
        
    }
    
    
    
    @IBAction func savePressed(_ sender : UIButton){
        registerRequest.driverLicensePicture = licenceImage
        registerRequest.idCardPicture = idImage
        registerRequest.carFromFrontPicture = frontImage
        registerRequest.carFromBehindPicture = backImage
        registerRequest.carRegistrationPicture  = registrationImage
        updateDeliveryUserProfile(registerRequest: registerRequest)
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
                        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true
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
