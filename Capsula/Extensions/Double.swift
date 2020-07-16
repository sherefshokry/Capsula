//
//  Double.swift
//  ADSC
//
//  Created by SherifShokry on 9/16/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
