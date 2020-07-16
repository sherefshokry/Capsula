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
        subView.layer.cornerRadius = 10
        subView.borderWidth = 1
        subView.borderColor = UIColor.init(codeString: "C7C9CB")
        insertSubview(subView, at: 0)
    }
}
