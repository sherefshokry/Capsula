//
//  URL.swift
//  Mansour
//
//  Created by SherifShokry on 11/24/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//
 
import Foundation
import UIKit


extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
