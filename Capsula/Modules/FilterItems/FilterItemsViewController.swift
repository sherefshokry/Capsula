//
//  FilterItemsViewController.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import ContentSheet
import Intercom

class FilterItemsViewController : UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var clearBtn : UIButton!
    @IBOutlet weak var highPriceSelectionImage : UIImageView!
    @IBOutlet weak var lowPriceSelectionImage : UIImageView!
    var filterType = -1
    var applyFilterPressed : ((Int) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBtn.setUnderLineText(text: Strings.shared.clear)
        if filterType == 1 {
            hieghestPricePressed(UIButton())
        }else if filterType == 2 {
            lowestPricePressed(UIButton())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              
              if Utils.loadUser()?.accessToken ?? "" != "" {
                 Intercom.setLauncherVisible(true)
              }
          }
      
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    //icNotSelected
    //icSelected
    
    @IBAction func lowestPricePressed(_ sender : UIButton){
        self.filterType = 2
        lowPriceSelectionImage.image = UIImage(named: "icSelected")
        highPriceSelectionImage.image = UIImage(named: "icNotSelected")
    }
    
    @IBAction func hieghestPricePressed(_ sender : UIButton){
        self.filterType = 1
        highPriceSelectionImage.image = UIImage(named: "icSelected")
        lowPriceSelectionImage.image = UIImage(named: "icNotSelected")
    }
    
    @IBAction func applyFilterPressed(_ sender : UIButton){
        if self.applyFilterPressed != nil {
        self.dismiss(animated: true) {
          self.applyFilterPressed?(self.filterType)
        }
       }
    }
    
    
    @IBAction func clearFilterPressed(_ sender : UIButton){
        self.filterType = -1
        highPriceSelectionImage.image = UIImage(named: "icNotSelected")
        lowPriceSelectionImage.image = UIImage(named: "icNotSelected")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.applyFilterPressed != nil {
                self.dismiss(animated: true) {
                    self.applyFilterPressed?(self.filterType)
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
