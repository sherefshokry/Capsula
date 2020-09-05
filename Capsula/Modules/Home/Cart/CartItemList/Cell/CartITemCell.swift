//
//  CartITemCell.swift
//  Capsula
//
//  Created by SherifShokry on 3/29/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import SwipeCellKit
class CartITemCell : SwipeTableViewCell{
   
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemName : UILabel!
    @IBOutlet weak var itemPrice : UILabel!
    @IBOutlet weak var itemQuantity : UILabel!
    @IBOutlet weak var plusBtn : UIButton!
    @IBOutlet weak var minusBtn : UIButton!
    var onPlusPressd : ((Item) -> ())?
    var onMinusPressd : ((Item) -> ())?
    var selectedItem = Item()
    
    override func awakeFromNib() {
        
    }
    
    func setItemData(item : Item) {
        
        selectedItem = item
        itemImage.sd_setImage(with: URL.init(string: item.imagePath ?? ""))
        itemName.text =  item.productName
        itemPrice.text = "\(item.price ?? 0.0)" + Strings.shared.rsd
        itemQuantity.text = "\(item.itemQuantity ?? 1)"
    }
    
    
    @IBAction func plusPressed(_ sender : UIButton){
          if onPlusPressd != nil {
             self.onPlusPressd?(selectedItem)
        }
    }
    
    @IBAction func minusPressed(_ sender : UIButton){
        if onMinusPressd != nil {
           self.onMinusPressd?(selectedItem)
        }
    }
    
    
    
 
    
    
}
