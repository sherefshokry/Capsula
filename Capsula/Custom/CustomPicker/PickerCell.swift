//
//  PickerCell.swift
//  MyLexus
//
//  Created by Nora on 6/25/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage

class PickerCell : UITableViewCell{
    
    @IBOutlet weak var carImage : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var selectedImageIcon : UIImageView!
    @IBOutlet weak var container : UIView!
    @IBOutlet weak var carImageWidth : NSLayoutConstraint!

    
    func setData(title : String  , image : String , selected : Bool){
//        carImage.setShowActivityIndicator(true)
//        carImage.setIndicatorStyle(.gray)
//        carImage.sd_setImage(with: URL.init(string: image), placeholderImage: nil)
//        carImageWidth.constant = (image == "") ? 0 : #imageLiteral(resourceName: "car").size.width
//        carImage.contentMode = .scaleAspectFit
        selectedImageIcon.image = selected ? #imageLiteral(resourceName: "icSelected") : #imageLiteral(resourceName: "icNotSelected")
        container.backgroundColor = selected ? UIColor.init(codeString: "#d8d8d8").withAlphaComponent(0.16) : UIColor.white
        titleLbl.text = title
    }
}
