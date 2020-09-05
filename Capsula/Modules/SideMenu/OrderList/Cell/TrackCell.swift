//
//  TrackCell.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
class TrackCell : UITableViewCell {
    
    
    @IBOutlet weak var orderDate : UILabel!
    @IBOutlet weak var orderStatus : UILabel!
   
    
    
    func setData(track : OrderTrack) {
        
         switch track.orderStatusId ?? -1 {
              case 1:
                orderStatus.text = Strings.shared.orderIs + " " + Strings.shared.pending
                  break
              case 2:
                  orderStatus.text = Strings.shared.orderIs + " " + Strings.shared.cancelled
                  break
              case 3:
                  orderStatus.text = Strings.shared.orderIs + " " +  Strings.shared.rejected
                  break
              case 4:
                  orderStatus.text = Strings.shared.orderIs + " " + Strings.shared.approved
                  break
              case 5:
                  orderStatus.text = Strings.shared.orderIs + " " + Strings.shared.shipped
                  break
              case 6:
                  orderStatus.text = Strings.shared.orderIs + " " + Strings.shared.delivered
                  break
              default:
                  print("no thing")
              }
        
     
        orderDate.text = track.operationDate?.timeFormat()
        
        
    }
    
    
    
    
    
}
