//
//  OrderCell.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit





class OrderCell : UITableViewCell {
    
    var selectedOrder = Order()
    @IBOutlet weak var orderDate : UILabel!
    @IBOutlet weak var orderStatus : UILabel!
    @IBOutlet weak var orderPrice : UILabel!
    @IBOutlet weak var dliveryAddress : UILabel!
    @IBOutlet weak var moreDetailsBtn : UIButton!
    var moreDetails : ((Order) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreDetailsBtn.setUnderLineText(text: Strings.moreDetails)
        
    }
    
    
    func setData(order : Order){
        
        selectedOrder  = order
        switch order.orderStatusId ?? -1 {
        case 1:
            orderStatus.text = Strings.pending
            break
        case 2:
            orderStatus.text = Strings.cancelled
            break
        case 3:
            orderStatus.text = Strings.rejected
            break
        case 4:
            orderStatus.text = Strings.approved
            break
        case 5:
            orderStatus.text = Strings.shipped
            break
        case 6:
            orderStatus.text = Strings.delivered
            break
        default:
            print("no thing")
        }
        orderDate.text = (order.orderDate ?? "").monthDateFormat()
        orderPrice.text = "\(order.finalTotalCost ?? 0.0)"
        dliveryAddress.text = order.deliveryAddress ?? ""
        
    }
    
    
    @IBAction func moreDetailsPressed(_ sender : UIButton){
        
        if moreDetails != nil {
            
            self.moreDetails?(selectedOrder)
            
        }
        
        
    }
    
    
    
    
    
    
}
