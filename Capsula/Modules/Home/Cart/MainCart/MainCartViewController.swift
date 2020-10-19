//
//  MainCartViewController.swift
//  Capsula
//
//  Created SherifShokry on 3/29/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Intercom
import SafariServices



class MainCartViewController: UIViewController, SFSafariViewControllerDelegate {
    
    // var initialSetupViewController: PTFWInitialSetupViewController!
    var selectedPaymentMethod = -1
    @IBOutlet weak var  headerView : UIView!
    @IBOutlet weak var  containerView : UIView!
    @IBOutlet weak var  cartProgressImage : UIImageView!
    var provider: OPPPaymentProvider?
    var transaction: OPPTransaction?
    var safariVC: SFSafariViewController?
    
    
    var items = [Item]()
    var presenter : ViewToPresenterMainCartProtocol?
    
    lazy var cartListVC : UIViewController = {
        let vc = CartItemListRouter.createModule() as! CartItemListViewController
        
        vc.nextPressed = {
            self.openDetailsScreen()
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                self.cartProgressImage.image = UIImage(named: "cart_second_ar")
            }else{
                self.cartProgressImage.image = UIImage(named: "cart_second")
            }
            //         cartProgressImage.image = UIImage(named: "cart_first")
            //         cartProgressImage.image = UIImage(named: "cart_third")
        }
        return vc
    }()
    
    lazy var cartListWithItemsVC : UIViewController = {
        let vc = CartItemListRouter.createModule() as! CartItemListViewController
        vc.items = items
        vc.nextPressed = {
            self.openDetailsScreen()
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                self.cartProgressImage.image = UIImage(named: "cart_second_ar")
            }else{
                self.cartProgressImage.image = UIImage(named: "cart_second")
            }
        }
        return vc
    }()
    
    
    lazy var cartDetailsViewController : CartDetailsViewController = {
        let vc = CartDetailsRouter.createModule() as! CartDetailsViewController
        vc.nextPressed = {
            self.openCongratScreen()
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                self.cartProgressImage.image = UIImage(named: "cart_third_ar")
            }else{
                self.cartProgressImage.image = UIImage(named: "cart_third")
            }
            
        }
        
        vc.openPaymentScreen = { (checkoutID,paymentMethod) in
            self.selectedPaymentMethod = paymentMethod
            self.openPaymentScreen(checkoutID: checkoutID, paymentMethod: paymentMethod)
        }
        
        
        return vc
    }()
    
    lazy var cartCongratViewController : UIViewController = {
        let vc = CartCongratViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
        
        return vc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if items.count > 0 {
            self.add(childViewContoller: cartListWithItemsVC)
        }else{
            self.add(childViewContoller: cartListVC)
            
        }
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            self.cartProgressImage.image = UIImage(named: "cart_first_ar")
        }else{
            self.cartProgressImage.image = UIImage(named: "cart_first")
        }
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Utils.loadUser()?.accessToken ?? "" != "" {
            Intercom.setLauncherVisible(true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 70
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
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
        UIApplication.shared.windows[0].visibleViewController?.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                self.requestPaymentStatus()
            }
        })
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
                self.cartDetailsViewController.presenter?.checkout(resourcePath: resourcePath, paymentMethod: self.selectedPaymentMethod)
                
            }
        }
    }
    
    
    func openCongratScreen() {
        add(childViewContoller: cartCongratViewController)
        remove(childViewContoller: cartListWithItemsVC)
        remove(childViewContoller: cartListVC)
        remove(childViewContoller: cartDetailsViewController)
    }
    
    
    
    func openDetailsScreen() {
        add(childViewContoller: cartDetailsViewController)
        remove(childViewContoller: cartListWithItemsVC)
        remove(childViewContoller: cartCongratViewController)
        remove(childViewContoller: cartListVC)
    }
    
    func openCartListScreen() {
        add(childViewContoller: cartListVC)
        remove(childViewContoller: cartCongratViewController)
        remove(childViewContoller: cartDetailsViewController)
    }
    
    
    
    private func add(childViewContoller : UIViewController){
        
        addChild(childViewContoller)
        self.containerView.addSubview(childViewContoller.view)
        
        childViewContoller.view.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leadingAnchor, right: containerView.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        childViewContoller.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewContoller.didMove(toParent: self)
    }
    
    private func remove(childViewContoller : UIViewController){
        
        childViewContoller.willMove(toParent: nil)
        childViewContoller.view.removeFromSuperview()
        childViewContoller.removeFromParent()
    }
    
    
}
extension MainCartViewController : PresenterToViewMainCartProtocol {
    
    
}
