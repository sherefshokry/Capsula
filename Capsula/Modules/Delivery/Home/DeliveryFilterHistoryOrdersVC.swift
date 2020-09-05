//
//  DeliveryFilterHistoryOrdersVC.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import ContentSheet
import Intercom
class DeliveryFilterHistoryOrdersVC : UIViewController {
    
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var clearBtn : UIButton!
    @IBOutlet weak var datePicker : UIDatePicker!
    var filterType = -1
    var applyFilterPressed : ((String) -> ())?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       clearBtn.setUnderLineText(text: Strings.shared.clear)
       datePicker.datePickerMode = .date
       datePicker.maximumDate = Date()
    }
    
    override func viewWillLayoutSubviews() {
          super.viewWillLayoutSubviews()
          topView.clipsToBounds = true
          topView.layer.cornerRadius = 70
          topView.layer.maskedCorners = [.layerMaxXMinYCorner]
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    
    @IBAction func applyFilterPressed(_ sender : UIButton){
         if self.applyFilterPressed != nil {
         self.dismiss(animated: true) {
            let pickedDate =  self.datePicker.date.toFilterString()
           self.applyFilterPressed?(pickedDate)
         }
        }
     }
    
    
    
    @IBAction func clearFilterPressed(_ sender : UIButton){
           self.filterType = -1

           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               if self.applyFilterPressed != nil {
                   self.dismiss(animated: true) {
                    self.applyFilterPressed?(Date().toFilterString())
                   }
               }
           }
       }
       
       
       
       override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
           return 900
       }
       
       override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
           return 370
       }
    
}

