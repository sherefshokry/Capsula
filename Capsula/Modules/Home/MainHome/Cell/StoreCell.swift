//
//  StoreCell.swift
//  Capsula
//
//  Created by SherifShokry on 8/14/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import SDWebImage

class StoreCell : UICollectionViewCell {
    
    @IBOutlet weak var  storeImage   : UIImageView!
    @IBOutlet weak var  storeName   : UILabel!
     @IBOutlet weak var storeDistance   : UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
   }

    func setStoreData(store : Store){
        storeImage.sd_setImage(with: URL.init(string: store.imageLink ?? ""))
        storeName.text = store.storeName ?? ""
        if (store.distance ?? 0.0) > 0.0 {
            storeDistance.text = Strings.shared.distance + "\(Int(store.distance ?? 0.0))" + Strings.shared.km
        }
        
    }
    

    override func layoutSubviews() {
          super.layoutSubviews()
          self.storeImage.layer.cornerRadius = 20
          self.storeImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      }
    
}
