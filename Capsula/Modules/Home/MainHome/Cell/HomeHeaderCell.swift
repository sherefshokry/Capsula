//
//  HomeHeaderCel.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import SDWebImage
enum SpecialItems : Int{
  case bestSeller = 0
  case topRated = 1
  case freeDlivery = 2
}

class HomeHeaderCell : UITableViewCell {
    
      @IBOutlet weak var headerView : UIView!
      @IBOutlet weak var userNameLbl : UILabel!
      @IBOutlet weak var userImage : UIImageView!
      @IBOutlet weak var cartView : UIView!
      @IBOutlet weak var cartNumberItemsLabel : UILabel!
    
       var specialItemsPressed : ((Int) -> ())?
       var itemSearchPressed: (() -> ())?
       var openCartPressed: (() -> ())?
       override func layoutSubviews() {
          super.layoutSubviews()
         headerView.clipsToBounds = true
         headerView.layer.cornerRadius = 70
         headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
     }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        //        Utils.saveUser(user: UserResponse())
        //        Utils.openLoginScreen()

        
        userNameLbl.text = Strings.shared.hello +  " \(Utils.loadUser()?.user?.name ?? "") 👋🏻"
        userImage.sd_setImage(with: URL.init(string: Utils.loadUser()?.user?.photo ?? ""), placeholderImage: UIImage(named: "icPersonal"))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.recieveCartNotification(_:)), name: NSNotification.Name(rawValue: Constants.CART_UPDATE_NOTIFICATION), object: nil)
         updateCartView()
        
    }
    
    @IBAction func openCartScreen(_ sender : UIButton){
              if openCartPressed != nil {
                       self.openCartPressed?()
                   }
    }
    
    
    @objc func recieveCartNotification(_ notification: NSNotification){
            updateCartView()
        }
        
            func updateCartView(){
              let cartItems = Utils.loadLocalCart() ?? []
              if (cartItems.count > 0){
                    cartView.isHidden = false
                    cartNumberItemsLabel.text = "\(cartItems.count)"
              }else{
                   cartView.isHidden = true
              }
             view.layoutIfNeeded()
          }
    
    
    @IBAction func bestSellerPressed(_ sender : UIButton){
        if specialItemsPressed != nil {
            self.specialItemsPressed?(SpecialItems.bestSeller.rawValue)
        }
    }
    
    @IBAction func topRatedPressed(_ sender : UIButton){
         if specialItemsPressed != nil {
               self.specialItemsPressed?(SpecialItems.topRated.rawValue)
           }
    }
    
    @IBAction func freeDliveryPressed(_ sender : UIButton){
           if specialItemsPressed != nil {
              self.specialItemsPressed?(SpecialItems.freeDlivery.rawValue)
          }
           
       }
    
 
    
    @IBAction func itemSearchPressed(_ sender : UIButton){
       if itemSearchPressed != nil {
                 self.itemSearchPressed?()
        }
    }
    
}
