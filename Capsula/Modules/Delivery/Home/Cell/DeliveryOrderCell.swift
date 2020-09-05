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
    @IBOutlet weak var navigateBtn : UIButton!
    
    
    var selectedOrder = DeliveryOrder()
    func setData(order : DeliveryOrder){
        selectedOrder = order
        orderID.text = Strings.shared.orderID + (order.orderCode ?? "")
        orderToLabel.text = order.customerName ?? ""
        orderAddress.text = order.customerAddress ?? ""
        phoneNumber.text =  "+96" + (order.phoneNumber ?? "")
      
        if order.statusId ?? -1 == 2 {
            navigateBtn.isHidden = false
        }else{
            navigateBtn.isHidden = true
        }
        
        
        switch order.statusId ?? -1 {
        case 1 :
            orderStatusLabel.isHidden = true
            orderStatusView.isHidden = true
            orderStatusLabel.text = Strings.shared.pending
            break
        case 2:
            orderStatusView.isHidden = false
            orderStatusLabel.isHidden = false
            orderStatusLabel.text = Strings.shared.inProgress
            break
        default:
          orderStatusLabel.isHidden = true
          orderStatusView.isHidden = true
        }
    }
    
   override func awakeFromNib() {
    super.awakeFromNib()
        navigateBtn.setUnderLineText(text: Strings.shared.navigate)
    }
    
    @IBAction func navigatePressed(_ sender : UIButton)
    {
        openGoogleMap()
    }
    
    
    func openGoogleMap() {
          
          if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
              
              if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(selectedOrder.customerLat ?? 0.0),\(selectedOrder.customerLong ?? 0.0)&directionsmode=driving") {
                  UIApplication.shared.open(url, options: [:])
              }}
          else {
              //Open in browser
              if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(selectedOrder.customerLat ?? 0.0),\(selectedOrder.customerLong ?? 0.0)&directionsmode=driving") {
                  UIApplication.shared.open(urlDestination)
              }
          }
          
      }
    
    
    
    
    
}
