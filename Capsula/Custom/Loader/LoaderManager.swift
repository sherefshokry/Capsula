//
//  LoaderManager.swift
//  Masters
//
//  Created by Nora on 3/7/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import UIKit

class LoaderManager: NSObject {
    
    var loader : LoaderView!
    let defaultColor = UIColor.white.withAlphaComponent(0.9)
    
    override init() {
        super.init()
        loader = Bundle.main.loadNibNamed("LoaderView", owner: self , options: nil)?.first as? LoaderView
    }
    
    
    func show(inRect rect : CGRect , inView view : UIView , bgColor : UIColor? =
        UIColor.white.withAlphaComponent(1) , radius : CGFloat? = 0 ){
        //        setPickerSpec()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            if bgColor != nil{
                loader.backgroundColor = bgColor
            }else{
                loader.backgroundColor = defaultColor
            }
            
            loader.frame = rect
            if radius != nil{
                loader.cornerRadius = radius ?? 0
            }
            view.addSubview(loader)
            view.bringSubviewToFront(loader)
            
        }
        
    }
    
    func remove(){
        loader.removeFromSuperview()
    }
}
