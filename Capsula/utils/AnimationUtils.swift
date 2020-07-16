//
//  AnimationUtils.swift
//  Mattel
//
//  Created by Karim abdelhameed mohamed on 10/30/19.
//  Copyright © 2019 Karim abdelhameed mohamed. All rights reserved.
//

import Foundation
import UIKit

class AnimationUtils{
    static func animateLeft(animatedView: UIView,hidden:Bool , duration:CFTimeInterval){
        let slideInFromLeftTransition = CATransition()
          slideInFromLeftTransition.type = CATransitionType.push
          slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
          slideInFromLeftTransition.duration = duration
          slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
          slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
           animatedView.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
           animatedView.isHidden = hidden
    }
    static func animateRight(animatedView : UIView,hidden:Bool,duration:CFTimeInterval){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        animatedView.layer.add(slideInFromLeftTransition, forKey: "slideInFromRightTransition")
        animatedView.isHidden = hidden
    }
}
