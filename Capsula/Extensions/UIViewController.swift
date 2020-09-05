//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
//import XCDYouTubeKit
import AVKit


extension UIViewController   {
    
   
    func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showMessage(_ message: String) -> Void {
      
       let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             switch action.style{
             case .default:
                alert.dismiss(animated: true, completion: nil)
             case .cancel:
                   alert.dismiss(animated: true, completion: nil)

             case .destructive:
                   alert.dismiss(animated: true, completion: nil)
       }}))
       self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String,completion : @escaping (()->())) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.shared.OK,style: UIAlertAction.Style.cancel, handler: {(action) in
            completion()
        }));
        
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessageWithRetry(_ message: String ,retryTitle : String ,completion : @escaping (()->())) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: retryTitle, style: UIAlertAction.Style.default, handler: {(action) in
            completion()
        }));
        alert.addAction(UIAlertAction(title: "Cancel".localize(), style: UIAlertAction.Style.cancel, handler: {(action) in
        }));
        
        present(alert, animated: true, completion: nil)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromStoryBoard(appStoryBoard : AppStoryboard)-> Self{
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    func showPleaseWaitAlert() {
        let pleaseWaitAlert = UIAlertController(title: nil, message:"Please wait.\n\n\n".localize(), preferredStyle: .alert)
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        spinner.center = CGPoint(x: 130.5, y: 65.5)
        spinner.color = UIColor.black
        spinner.startAnimating()
        pleaseWaitAlert.view!.addSubview(spinner)
        self.present(pleaseWaitAlert, animated: false, completion: nil)
    }
    
    //    func openHome(){
    //        let nvc = UINavigationController(rootViewController: TabBarViewController.instantiateFromStoryBoard(appStoryBoard: .Home))
    //          nvc.navigationBar.isHidden = true
    //          UIApplication.shared.windows[0].rootViewController = nvc
    //          UIApplication.shared.windows[0].makeKeyAndVisible()
    //    }
    
    //    func setupHomeWithSideMenu()  {
    //        SlideMenuOptions.leftViewWidth = 300
    //        SlideMenuOptions.contentViewScale = 1.0
    //        SlideMenuOptions.hideStatusBar = false
    //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    //        let mainViewController = HomeRouter.createModule()//mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
    //
    //        let menuViewController = MenuRouter.createModule() as? MenuViewController
    //
    //
    //        menuViewController?.mainViewController = mainViewController
    
    //        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
    //
    //        let slideMenuController:SlideMenuViewController?  = SlideMenuViewController(mainViewController:mainViewController, leftMenuViewController: menuViewController ?? UIViewController()) as SlideMenuViewController
    //            UIApplication.shared.windows[0].rootViewController = slideMenuController
    //            UIApplication.shared.windows[0].makeKeyAndVisible()
    //
    //        }else{
    //            let slideMenuController:SlideMenuViewController?  = SlideMenuViewController(mainViewController: mainViewController, rightMenuViewController: menuViewController!)
    //            UIApplication.shared.windows[0].rootViewController = slideMenuController
    //            UIApplication.shared.windows[0].makeKeyAndVisible()
    //        }
    //    }
    //
    ////    func setupHomeWithSideMenu(selectedTabIndex : Int)  {
    ////        SlideMenuOptions.leftViewWidth = 300
    ////        SlideMenuOptions.contentViewScale = 1.0
    ////        SlideMenuOptions.hideStatusBar = false
    ////        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    ////        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewContorller") as! HomeViewContorller
    ////        mainViewController.selectedTab = selectedTabIndex
    ////        let menuViewController = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    ////
    ////        menuViewController.mainViewController = mainViewController
    ////
    ////        let slideMenuController:SlideMenuViewController?  = SlideMenuViewController(mainViewController:mainViewController, leftMenuViewController: menuViewController) as SlideMenuViewController
    ////
    ////        UIApplication.shared.windows[0].rootViewController = slideMenuController
    ////        UIApplication.shared.windows[0].makeKeyAndVisible()
    ////    }
    //
    //    @IBAction func showNotification(_ sender: Any) {
    //        let vc = NotificationRouter.createModule()
    //        self.present(vc, animated: true, completion: nil)
    //    }
    //
    //    @IBAction func showSideMenu(_ sender: Any) {
    
    //        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
    //            self.slideMenuController()?.openLeft()
    //        }else{
    //            self.slideMenuController()?.openRight()
    //        }
    //    }
    //
    //    func hideSideMenu(){
    //        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
    //            self.slideMenuController()?.closeLeft()
    //        }else{
    //            self.slideMenuController()?.closeRight()
    //        }
    //    }
    //
    //    func makePhoneCall(phoneNumber : String){
    //        guard let number = URL(string: "tel://" + phoneNumber) else { return }
    //        UIApplication.shared.open(number)
    //    }
    //
    //    func showInternetAlert( funcToLoad : @escaping (()->()) ){
    //
    //        let alert = UIAlertController(title: "Please check your internet connection then try again.".localize(), message: "" , preferredStyle: UIAlertController.Style.alert)
    //
    //        alert.addAction(UIAlertAction(title: "Cancel".localize() , style: UIAlertAction.Style.cancel , handler: {(UIAlertAction) in
    //
    //        }))
    //        alert.addAction(UIAlertAction(title: "Try again".localize() , style: UIAlertAction.Style.default , handler: {(UIAlertAction) in
    //
    //
    //            funcToLoad()
    //
    //
    //        }
    //
    //        ))
    //        self.present(alert, animated: true, completion: nil)
    //
    //    }
    //
    func areYouSureMsg(Msg : String , funcToLoad : @escaping ((Bool)->()) ){
        
        let alert = UIAlertController(title: Msg , message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: Strings.shared.no , style: UIAlertAction.Style.cancel , handler: {(UIAlertAction) in
            funcToLoad(false)
        }))
        alert.addAction(UIAlertAction(title: Strings.shared.yes , style: UIAlertAction.Style.default , handler: {(UIAlertAction) in
            funcToLoad(true)
            
        }
            
        ))
        self.present(alert, animated: true, completion: nil)
        
    }
    //
    //    func PlayVideo(url : String){
    //
    //        if  url.youtubeID != nil {
    //            playYoutubeVideo(videoIdentifier: url.youtubeID)
    //        }else{
    //            if let vedioURL =  URL.init(string: url) {
    //                let player = AVPlayer(url:vedioURL)
    //                let playerViewController = AVPlayerViewController()
    //                playerViewController.player = player
    //
    //                if let currentVC = UIApplication.shared.windows[0].visibleViewController{
    //                    currentVC.present(playerViewController, animated: true) {
    //                        player.play()
    //                    }
    //                }
    //            }
    //        }
    //    }
    //
    //    struct YouTubeVideoQuality {
    //        static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    //        static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    //        static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
    //    }
    //
    //    func playYoutubeVideo(videoIdentifier: String?) {
    //        let playerViewController = AVPlayerViewController()
    //        if let currentVC = UIApplication.shared.windows[0].visibleViewController{
    //            currentVC.present(playerViewController, animated: true) {
    //
    //            }
    //        }
    //        XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
    //            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
    //                playerViewController?.player = AVPlayer(url: streamURL)
    //                playerViewController?.player?.play()
    //            }
    //        }
    //    }
    //
    //
    //    func delay(_ delay:Double, closure:@escaping ()->()) {
    //        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
    //            closure()
    //        }
    //    }
    //
    //    func isEmailAddress(_ emailAddress: String) -> Bool {
    //        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    //
    //        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
    //        return test.evaluate(with: emailAddress)
    //    }
    //
    //    func isMobileNumber(_ mobileNumber: String) -> Bool {
    //        if mobileNumber.length < 6 {
    //            return false
    //        }
    //        let charcterSet  = CharacterSet(charactersIn: "+0123456789").inverted
    //        let inputString = mobileNumber.components(separatedBy: charcterSet)
    //        let filtered = inputString.joined(separator: "")
    //        return  mobileNumber == filtered
    //    }
    //
    //    func textHasOnlyNumbers(_ text: String) -> Bool {
    //
    //        let charcterSet  = CharacterSet(charactersIn: "0123456789").inverted
    //        let inputString = text.components(separatedBy: charcterSet)
    //        let filtered = inputString.joined(separator: "")
    //        return  text == filtered
    //    }
    //
    //
    //    @IBAction func backPop(_ sender : Any){
    //        self.navigationController?.popViewController(animated: true)
    //    }
    @IBAction func backDismiss(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
    //
    //
    //
    //    @IBAction func openLogin(_ sender : Any){
    //        self.present(LoginRouter.createModule(), animated: true, completion: nil)
    //    }
    //
    //    @IBAction func openRegister(_ sender : Any){
    //        let vc = CreateAccountRouter.createModule(userRequest: UserRequest())
    //        self.present(vc, animated: true, completion: nil)
    //    }
    //
    //    func appIsArabic()->Bool{
    //        let language = Bundle.main.preferredLocalizations[0] as NSString
    //        if language.contains("ar"){
    //            return true
    //        }
    //        else{
    //            return false
    //        }
    //    }
}
