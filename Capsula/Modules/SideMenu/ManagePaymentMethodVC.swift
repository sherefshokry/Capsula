//
//  ManagePaymentMethodVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import ContentSheet
import SafariServices
import Moya
import KVNProgress


class ManagePaymentMethodVC : UIViewController,  SFSafariViewControllerDelegate {
    
    
    private let checkoutProvider = MoyaProvider<CheckOutDataSource>()
    var provider: OPPPaymentProvider?
    var transaction: OPPTransaction?
    var safariVC: SFSafariViewController?
    @IBOutlet weak var topView : UIView!
    var applyPaymentMethod : ((Int) -> ())?
    var paymentType = -1
    @IBOutlet weak var visaSelectedIcon : UIImageView!
    @IBOutlet weak var madaSelectedIcon : UIImageView!
    @IBOutlet weak var appleSelectedIcon : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if paymentType == 5 {
            maddaPressed(UIButton())
        }else if paymentType == 4 {
            visaPressed(UIButton())
        }else if paymentType == 2 {
            applePressed(UIButton())
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    
    
    @IBAction func maddaPressed(_ sender : UIButton){
        madaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        appleSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        paymentType = 5
    }
    
    @IBAction func visaPressed(_ sender : UIButton){
        madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        appleSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
        visaSelectedIcon.image = #imageLiteral(resourceName: "timeline")
        paymentType = 4
    }
    
    @IBAction func applePressed(_ sender : UIButton){
            madaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
            visaSelectedIcon.image = #imageLiteral(resourceName: "icNotSelected")
            appleSelectedIcon.image = #imageLiteral(resourceName: "timeline")
            paymentType = 2
       }
    
    
    @IBAction func applyPaymentMethodPressed(_ sender : UIButton){
        if self.applyPaymentMethod != nil {
            if paymentType == -1 {
                self.showMessage(Strings.shared.paymentMethodSelection)
            }else{
                //Call API
                self.prepareRegistration(paymentMethodID: paymentType)
            }
            
        }
    }
    
    func prepareRegistration(paymentMethodID: Int) {
       KVNProgress.show(withStatus: "", on: self.view)
       checkoutProvider.request(.prepareRegistration(paymentMethodID)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
            
                    let checkoutIDResponse = try response.map(BaseResponse<String>.self)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {  self.openPaymentScreen(checkoutID: checkoutIDResponse.data ?? "", paymentMethod: paymentMethodID)
                                                 
                     }
                         
                    
                } catch(let catchError) {
                    self.showMessage(catchError.localizedDescription)
                }
            case .failure(let error):
                do{
                    if let body = try error.response?.mapJSON(){
                        let errorData = (body as! [String:Any])
                        self.showMessage((errorData["errors"] as? String) ?? "")                    }
                }catch{
                    self.showMessage(error.localizedDescription)
                }
            }
        }
    }
    
    
    func openPaymentScreen(checkoutID : String , paymentMethod : Int){
       
        
        
        self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        
        let checkoutSettings = OPPCheckoutSettings()
        
        // Set available payment brands for your shop
        
        if paymentMethod == 4 {
            checkoutSettings.paymentBrands = ["VISA", "MASTER"]
        }else if paymentMethod == 5 {
            checkoutSettings.paymentBrands = ["MADA"]
        }else if paymentMethod == 2 {
            checkoutSettings.paymentBrands = ["APPLEPAY"]
        }
        checkoutSettings.storePaymentDetails = .always
        checkoutSettings.theme.confirmationButtonColor = UIColor.init(codeString: "#0E518A")
        checkoutSettings.theme.navigationBarBackgroundColor =  UIColor.init(codeString: "#37B6FF")
        checkoutSettings.theme.accentColor =  UIColor.init(codeString: "#37B6FF")
        checkoutSettings.theme.separatorColor = UIColor.lightGray
        checkoutSettings.theme.activityIndicatorPrimaryStyle = .gray
        checkoutSettings.theme.activityIndicatorSecondaryStyle = .gray
        checkoutSettings.theme.primaryFont = UIFont.systemFont(ofSize: 14.0)
        checkoutSettings.theme.secondaryFont = UIFont.systemFont(ofSize: 12.0)
        checkoutSettings.theme.confirmationButtonFont = UIFont.boldSystemFont(ofSize: 16)
        checkoutSettings.theme.errorFont = UIFont.systemFont(ofSize: 12.0)
        
        // Set shopper result URL
        checkoutSettings.shopperResultURL = "com.BinoyedSA.Capsula.payments://result"
        
        
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider!, checkoutID: checkoutID, settings: checkoutSettings)
        
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                // Handle invalid transaction, check error
                
                
                return
            }
            
            self.transaction = transaction
            
            
            if transaction.type == .synchronous {
                 // If a transaction is synchronous, just request the payment status
                self.requestPaymentStatus()
            } else if transaction.type == .asynchronous {
                // If a transaction is asynchronous, you should open transaction.redirectUrl in a browser
                // Subscribe to notifications to request the payment status when a shopper comes back to the app
                NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                self.presenterURL(url: self.transaction!.redirectURL!)
            } else {
                Utils.showResult(presenter: self, success: false, message: "Invalid transaction")
            }})
    }
    
    func presenterURL(url: URL) {
        self.safariVC = SFSafariViewController(url: url)
        self.safariVC?.delegate = self
        self.present(safariVC!, animated: true, completion: nil)
    }
    
    @objc func didReceiveAsynchronousPaymentCallback() {
        
        
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        
        
        
              DispatchQueue.main.async {
                       self.requestPaymentStatus()
                }
        
//        UIApplication.shared.windows[0].visibleViewController?.dismiss(animated: true, completion: {
//
//        })
        //        self.safariVC?.dismiss(animated: true, completion: {
        //
        //        })
    }
    
    func requestPaymentStatus() {
        // You can either hard-code resourcePath or request checkout info to get the value from the server
        // * Hard-coding: "/v1/checkouts/" + checkoutID + "/payment"
        // * Requesting checkout info:
        
        
        
        guard let checkoutID = self.transaction?.paymentParams.checkoutID else {
            Utils.showResult(presenter: self, success: false, message: "Checkout ID is invalid")
            return
        }
        self.transaction = nil
        
        //self.processingView.startAnimating()
        self.provider!.requestCheckoutInfo(withCheckoutID: checkoutID) { (checkoutInfo, error) in
            DispatchQueue.main.async {
                guard let resourcePath = checkoutInfo?.resourcePath else {
                    // self.processingView.stopAnimating()
                    Utils.showResult(presenter: self, success: false, message: "Checkout info is empty or doesn't contain resource path")
                    return
                }
                
                print("Resource PAth : \(resourcePath)")
                //Send resource path to samir api
                self.saveCard(paymentMethod :  self.paymentType , resourcePath : resourcePath)
            }
        }
    }
    
    func saveCard(paymentMethod : Int, resourcePath : String){
        
        
        KVNProgress.show(withStatus: "", on: self.view)
        checkoutProvider.request(.saveCard(paymentMethod, resourcePath)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.showMessage(Strings.shared.cardAddedSuccessfully) {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                do{
                    if let body = try error.response?.mapJSON(){
                        let errorData = (body as! [String:Any])
                        self.showMessage((errorData["errors"] as? String) ?? "")                    }
                }catch{
                    self.showMessage(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    
    
    
    override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 900
    }
    
    override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 600
    }
    
}

