//
//  DeliveryOrderCell.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class DeliveryOrderCell : UITableViewCell {
    
    @IBOutlet weak var orderID : UILabel!
    @IBOutlet weak var phoneNumber : UILabel!
    @IBOutlet weak var orderAddress : UILabel!
    @IBOutlet weak var orderToLabel : UILabel!
    @IBOutlet weak var orderStatusLabel : UILabel!
    @IBOutlet weak var orderStatusView : UIView!
    
    
    func setData(order : DeliveryOrder){
        
        orderID.text = Strings.orderID + (order.orderCode ?? "")
        orderToLabel.text = order.customerName ?? ""
        orderAddress.text = order.customerAddress ?? ""
        phoneNumber.text =  "+96" + (order.phoneNumber ?? "")
      
      
     
        
        switch order.statusId ?? -1 {
        case 1 :
            orderStatusLabel.isHidden = true
            orderStatusView.isHidden = true
            orderStatusLabel.text = Strings.pending
            break
        case 2:
            orderStatusView.isHidden = false
            orderStatusLabel.isHidden = false
            orderStatusLabel.text = Strings.inProgress
            break
        default:
          orderStatusLabel.isHidden = true
          orderStatusView.isHidden = true
        }
        
        
        
    }
    
    
    
    
    
}
