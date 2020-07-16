//
//  CMTime.swift
//  ADSC
//
//  Created by SherifShokry on 9/16/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import UIKit
import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            print("nil")
            return "00:00"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds % (60 * 60) / 60
        //  let hours = totalSeconds / 60 / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
