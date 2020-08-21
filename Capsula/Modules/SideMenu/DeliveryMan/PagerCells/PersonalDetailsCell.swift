//
//  PersonalDetailsCell.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import FSPagerView


class PersonalDetailsCell : FSPagerViewCell  {
    
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var phoneLabel : UILabel!
    @IBOutlet weak var nationalIDLabel : UILabel!
    @IBOutlet weak var citizenShipLabel : UILabel!
    @IBOutlet weak var bankAccountLabel : UILabel!
    @IBOutlet weak var fullAddressLabel : UILabel!
   
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
    
    
    func setData() {
        let deliveryUser = Utils.loadDeliveryUser()?.user ?? DeliveryUser()
        emailLabel.text = deliveryUser.email ?? ""
        phoneLabel.text = "+96" + (deliveryUser.phoneNumber ?? "")
        nationalIDLabel.text = deliveryUser.nationalId ?? ""
        citizenShipLabel.text = deliveryUser.nationalityDesc ?? ""
        bankAccountLabel.text = deliveryUser.bankAccountNumber ?? ""
        fullAddressLabel.text = deliveryUser.addressDesc ?? ""
    }
    
    
    
    
    
    
}
