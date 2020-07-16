//
//  AddressCell.swift
//  Capsula
//
//  Created by SherifShokry on 4/20/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class AddressCell : UITableViewCell {
    
    @IBOutlet weak var addressTitle : UILabel!
    @IBOutlet weak var checkImage : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setData(address : Address){
        
        addressTitle.text = address.addressDesc ?? ""
        
        if (address.isSelected) {
            checkImage.image = #imageLiteral(resourceName: "icSelected")
        }else{
            checkImage.image = #imageLiteral(resourceName: "icNotSelected")
        }
        
    }
    
}
