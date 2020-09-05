//
//  CarDetailsCell.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import FSPagerView


class CarDetailsCell : FSPagerViewCell  {

     @IBOutlet weak var carModelLabel : UILabel!
     @IBOutlet weak var carTypeLabel : UILabel!
     @IBOutlet weak var carYearLabel : UILabel!
     @IBOutlet weak var licenceTypeLabel : UILabel!
     @IBOutlet weak var carNumberLabel : UILabel!
    
     override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       
       }
     
     
     func setData() {
         let deliveryUser = Utils.loadDeliveryUser()?.user ?? DeliveryUser()
         carModelLabel.text = deliveryUser.carModelDesc ?? ""
         carTypeLabel.text = deliveryUser.carTypeDesc ?? ""
        carYearLabel.text = Strings.shared.model + " - " + (deliveryUser.yearDesc ?? "")
         licenceTypeLabel.text = deliveryUser.vehicleTypeDesc
         carNumberLabel.text = (deliveryUser.vehiclePlateLetters ?? "") + " " + "\(deliveryUser.vehiclePlateNumber ?? 0)"
     }
     
    
    
    

}
