//
//  NotificationCell.swift
//  Capsula
//
//  Created by SherifShokry on 9/23/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class NotificationCell : UITableViewCell {
    
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationDesc: UILabel!
    @IBOutlet weak var notificationDate: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    func setData(notificationItem : UserNotification){
        notificationTitle.text = notificationItem.title
        notificationDesc.text = notificationItem.body
        notificationDate.text =  (notificationItem.date?.monthFormat() ?? "") + " " +  (notificationItem.date?.timeFormat() ?? "")
        if notificationItem.image ?? "" != "" {
            imageWidth.constant = 48
            notificationImage.sd_setImage(with: URL.init(string:  notificationItem.image ?? ""))
        }else{
             imageWidth.constant = 0
        }
    }
    
}
