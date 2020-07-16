//
//  NoData.swift
//  Masters
//
//  Created by Nora on 2/27/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.



import UIKit

class NoData: NSObject {

    var noDataView : NoDataView!
    
    override init() {
        super.init()
        noDataView = Bundle.main.loadNibNamed("NoDataView", owner: self , options: nil)?.first as? NoDataView
    }
    
    func show(inRect rect : CGRect , withMsg msg : String,image : UIImage){
    
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            noDataView.frame = rect
            noDataView.msgLbl.text = msg
            noDataView.noDataImageView.image = image
            topController.view.addSubview(noDataView)
        }
    }
    
    
    func show(inRect rect : CGRect ,in view  : UIView){
        noDataView.frame = rect
        view.addSubview(noDataView)
    }
    

    
    
    func show(inRect rect : CGRect ,in view  : UIView , withMsg msg : String,image : UIImage){
        
            // topController should now be your topmost view controller
            noDataView.frame = rect
            noDataView.msgLbl.text = msg
            noDataView.noDataImageView.image = image
            view.addSubview(noDataView)
        
    }
    
    func remove(){
        noDataView.removeFromSuperview()
    }
    
}
