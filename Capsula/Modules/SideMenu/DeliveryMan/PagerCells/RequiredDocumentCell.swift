//
//  RequiredDocumentCell.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import FSPagerView


class RequiredDocumentCell : FSPagerViewCell  {
    
    @IBOutlet weak var  carLicenceImage : UIImageView!
    @IBOutlet weak var  nationalIDImage : UIImageView!
    @IBOutlet weak var  carFrontImage : UIImageView!
    @IBOutlet weak var  carBackImage : UIImageView!
    @IBOutlet weak var  carRegistrationImage : UIImageView!
    
    
    func setData(){
        
        let deliveryUser = Utils.loadDeliveryUser()?.user ?? DeliveryUser()
        carLicenceImage.sd_setImage(with: URL.init(string: deliveryUser.driverLicensePicture ?? ""), placeholderImage: nil)
        nationalIDImage.sd_setImage(with: URL.init(string: deliveryUser.idCardPicture ?? ""), placeholderImage: nil)
        carFrontImage.sd_setImage(with: URL.init(string: deliveryUser.carFromFrontPicture ?? ""), placeholderImage: nil)
        carBackImage.sd_setImage(with: URL.init(string: deliveryUser.carFromBehindPicture ?? ""), placeholderImage: nil)
        carRegistrationImage.sd_setImage(with: URL.init(string: deliveryUser.carRegistrationPicture ?? ""), placeholderImage: nil)
        

    }
    
    
    
    
    
    
    
    
    
}
