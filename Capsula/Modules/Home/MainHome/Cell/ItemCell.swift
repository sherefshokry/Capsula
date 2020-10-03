//
//  ItemCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell : UICollectionViewCell {
    
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemTitle : UILabel!
    @IBOutlet weak var itemPrice : UILabel!
    @IBOutlet weak var offerLabel : UILabel!
    @IBOutlet weak var offerView : UIView!
    @IBOutlet weak var addCartBtn : UIButton!
    var selectedItem = Item()
    var addToCardPressed : ((Item) -> ())?
    
    
    
    
    func setData(item : Item){
        selectedItem = item
        if selectedItem.itemQuantity == 0 {
             selectedItem.itemQuantity = 1
        }
        itemImage.sd_setImage(with: URL.init(string: item.imagePath ?? ""))
        itemTitle.text =  item.productName
        itemPrice.text = "\(item.price ?? 0.0)" + Strings.shared.rsd
        
        
        
        if item.offerType == -1 {
            offerView.isHidden = true
            offerLabel.isHidden = true
        }else{
            offerView.isHidden = false
            offerLabel.isHidden = false
            
            switch item.offerType {
            case 1:
                offerLabel.text = Strings.shared.freeDelivery
                break
            case 2:
                offerLabel.text = Strings.shared.offer
                break
            case 3:
                offerLabel.text = Strings.shared.discount
                break
            default:
                offerLabel.text = ""
            }
            
            
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setupLayout(){
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            addCartBtn.setImage(#imageLiteral(resourceName: "AddtoCartAR"), for: .normal)
        }else{
            addCartBtn.setImage(#imageLiteral(resourceName: "addToCart"), for: .normal)
        }
        
        
    }
    
    @IBAction func addToCart(_ sender : UIButton){
        
        if addToCardPressed != nil {
            self.addToCardPressed?(selectedItem) }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.itemImage.layer.cornerRadius = 20
        self.itemImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
}
