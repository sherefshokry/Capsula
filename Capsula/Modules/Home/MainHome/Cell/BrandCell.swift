//
//  BrandCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import SDWebImage

class BrandCell : UICollectionViewCell {

    @IBOutlet weak var brandImage  : UIImageView!
    
    func setData(brand : Brand){
        brandImage.sd_setImage(with: URL.init(string: brand.imageLink ?? ""))
   }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    
    }
  
    
    
    
    
    
    
    
}
