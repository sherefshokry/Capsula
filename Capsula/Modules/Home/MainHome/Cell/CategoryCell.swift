//
//  CategoryCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import SDWebImage

class CategoryCell : UICollectionViewCell {
    
    @IBOutlet weak var categoryImage   : UIImageView!
    @IBOutlet weak var categoryName   : UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
   }
    
    func setCategoryData(category : Category){
        categoryImage.sd_setImage(with: URL.init(string: category.imageLink ?? ""))
        categoryName.text = category.categoryName ?? ""
    }
    
    func setStoreData(store : Store){
        categoryImage.sd_setImage(with: URL.init(string: store.imageLink ?? ""))
        categoryName.text = store.storeName ?? ""
    }
    

    override func layoutSubviews() {
          super.layoutSubviews()
          self.categoryImage.layer.cornerRadius = 20
          self.categoryImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      }

    
}
