//
//  AppDelegate.swift
//  Capsula
//
//  Created by SherifShokry on 12/23/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import TwitterKit
import MOLH
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import Intercom



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , MessagingDelegate {
    
    var window: UIWindow?
    static let googleSignInId = "\(Constants.KEYS.googleSignInKey).apps.googleusercontent.com"
    let INTERCOM_APP_ID = "zwlcn8xj"
    let INTERCOM_API_KEY = "ios_sdk-55af3668b7fab69cfbd8603ec8bcf1d4bb8ff1a3"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyCx2XM-jUdvo5cOSJWIBwcayQEL4MO9-OQ")
        GMSPlacesClient.provideAPIKey("AIzaSyCx2XM-jUdvo5cOSJWIBwcayQEL4MO9-OQ")
        //AIzaSyAy7wIubAmmdvAR2AxeaoBX43FuF5k1m4w
        
        Utils.openSplashScreen() 
     
     
        
        UIFont.overrideInitializeForEN()
        
        FirebaseApp.configure()
        
        MOLH.shared.activate(false)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        TWTRTwitter.sharedInstance().start(withConsumerKey: Constants.KEYS.twitterConsumerKey, consumerSecret:  Constants.KEYS.twitterConsumerSecretKey)
        GIDSignIn.sharedInstance().clientID = AppDelegate.googleSignInId
        Messaging.messaging().delegate = self
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = UIColor.init(red: 55/255, green: 182/255, blue: 255/255, alpha: 1)
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: (sharedApplication.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor =  UIColor.init(red: 55/255, green: 182/255, blue: 255/255, alpha: 1)
            sharedApplication.delegate?.window??.addSubview(statusBar)
        }else{
            UINavigationBar.appearance().clipsToBounds = true
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.backgroundColor = UIColor.init(red: 55/255, green: 182/255, blue: 255/255, alpha: 1)
        }
        
    
        Intercom.setApiKey(INTERCOM_API_KEY, forAppId: INTERCOM_APP_ID)
        
        #if DEBUG
                  Intercom.enableLogging()
              #endif
        if Utils.loadUser()?.accessToken ?? "" != "" {
            Intercom.registerUser(withEmail: Utils.loadUser()?.user?.email ?? "")
        }
                 
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL?)
        
        let facebookDidHandle = ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        
        
        let twitterAuthentication = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        
        if url.scheme?.localizedCaseInsensitiveCompare("com.BinoyedSA.Capsula.payments") == .orderedSame {
                 // Send notification to handle result in the view controller.
                 NotificationCenter.default.post(name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                 return true
             }
        
        return googleDidHandle || facebookDidHandle || twitterAuthentication
    }
    
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
            return false
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         Intercom.setDeviceToken(deviceToken)
     }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let defaults = UserDefaults.standard
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        defaults.set(fcmToken, forKey: "device_token")
        defaults.set(deviceId , forKey: "device_id")
    }

     func applicationDidBecomeActive(_ application: UIApplication) {
         //Register for push notifications
         //For more info, see: https://developers.intercom.com/installing-intercom/docs/ios-push-notifications
         let center = UNUserNotificationCenter.current()
         // Request permission to display alerts and play sounds.
         center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
             // Enable or disable features based on authorization.
         }
         UIApplication.shared.registerForRemoteNotifications()
     }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var handle: Bool = true
        
        let options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject, UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
        
        handle = TWTRTwitter.sharedInstance().application(application, open: url, options: options)
        
        
        return handle
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
   
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
}

