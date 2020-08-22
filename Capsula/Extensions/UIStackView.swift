//
//  UIStackView.swift
//  Mansour
//
//  Created by SherifShokry on 11/26/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//
import UIKit


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 15
        subView.layer.shadowColor = UIColor.init(red: 47/22, green: 66/255, blue: 86/255, alpha: 0.3).cgColor
        subView.layer.shadowOpacity = 3
        subView.layer.shadowOffset = CGSize.zero
        subView.layer.shadowRadius = 3
        insertSubview(subView, at: 0)
    }
}
