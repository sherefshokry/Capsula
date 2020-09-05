//
//  Utils.swift
//  Loreal Medical
//
//  Created by Nora on 3/18/18.
//  Copyright © 2018 Nora. All rights reserved.
//
import Foundation
import UIKit
import EventKit
import ContentSheet

enum AppStoryboard : String {
    case Home = "Home"
    case PreLogin = "PreLogin"
    case Main = "Main"
    case Car = "Car"
    case Services = "Services"
    case SideMenu = "SideMenu"
    case Installment = "Installment"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type)->T{
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID ) as! T
    }
}

class Utils {
    
    static func openHomeScreen(){
        let vc = MainHomeRouter.createModule()
        UIApplication.shared.windows[0].rootViewController = vc
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    
    static func openDeliveryHomeScreen(){
        let vc =  DeliveryHomeVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        UIApplication.shared.windows[0].rootViewController = vc
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    static func openWelcomeScreen(){
        let vc =  WelcomeViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
        UIApplication.shared.windows[0].rootViewController = vc
        UIApplication.shared.windows[0].makeKeyAndVisible()
        
    }
    
    
        static func openSplashScreen() {
            let vc = SplashVC.instantiateFromStoryBoard(appStoryBoard: .Main)
            UIApplication.shared.windows[0].rootViewController = vc
            UIApplication.shared.windows[0].makeKeyAndVisible()
        }
    
    static func openLoginScreen(isDeliveryMan : Bool) {
        let vc = MainRegisterRouter.createModule(isDeliveryMan: isDeliveryMan)
        UIApplication.shared.windows[0].rootViewController = vc
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    //
    //    static func openRegisterScreen() {
    //        let vc = RegisterPhoneRouter.createModule()
    //        UIApplication.shared.windows[0].rootViewController = vc
    //        UIApplication.shared.windows[0].makeKeyAndVisible()
    //    }
    //
    //    static func navigateToMap(location : TestDriveLocation){
    //
    //        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
    //            let mURL = "comgooglemaps://?daddr=\(location.lat ?? 0.0),\(location.lng ?? 0.0)"
    //            UIApplication.shared.open(URL(string: mURL)!, options: [:], completionHandler: nil)
    //        } else {
    //            print("Can't use comgooglemaps://")
    //
    //            let mURL = "http://maps.google.com/?daddr=\(location.lat ?? 0.0),\(location.lng ?? 0.0)"
    //            UIApplication.shared.open(URL.init(string: mURL)!, options: [:], completionHandler: nil)
    //        }
    //
    //    }
    //
    static func isNotificationOn() -> Bool {
        let notificationStatus = UserDefaults.standard.value(forKeyPath: CachingModel.CachingKeys.NOTIFICATION_STATUS) as? Bool ?? true
        return notificationStatus
    }
    
    
    static func setNotificationStatus(){
        
        let status = isNotificationOn()
        let notifcationStatus = status ? false : true
        UserDefaults.standard.set(notifcationStatus, forKey: CachingModel.CachingKeys.NOTIFICATION_STATUS)
        
        if notifcationStatus  {
            UIApplication.shared.registerForRemoteNotifications()
            FirebaseUtils.subscribeToAllTopic()
        }else{
            UIApplication.shared.unregisterForRemoteNotifications()
            FirebaseUtils.unSubscribeFromAllTopics()
        }
        
    }
    
    
    static func getDeviceID() -> String {
        let deviceId =  UIDevice.current.identifierForVendor?.uuidString ?? ""
        return deviceId
    }
    
    
    static func getFCMToken() -> String {
        let defaults = UserDefaults.standard
        let fcmToken = defaults.string(forKey: "device_token") ?? ""
        return fcmToken
    }
    
    static func setLang(lang : String){
          if lang == "en" {
              UserDefaults.standard.set(["en", "ar"], forKey: "AppleLanguages")
          }else{
              UserDefaults.standard.set(["ar", "en"], forKey: "AppleLanguages")
          }
          UserDefaults.standard.set(lang, forKey: "lang")
      }
    
    
    
    static func saveUser(user: UserResponse?) {
        
        if let value = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(value, forKey: "user")
            UserDefaults.standard.synchronize()
        }else {
            UserDefaults.standard.set(nil, forKey: "user")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> UserResponse! {
        if let value = UserDefaults.standard.value(forKey: "user") as? Data {
            if let user = try? JSONDecoder().decode(UserResponse.self, from: value ) {
                return user
            }
        }
        return nil
    }
    
    
    static func saveDeliveryUser(user: DeliveryUserResponse?) {
        
        if let value = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(value, forKey: "deliveryUser")
            UserDefaults.standard.synchronize()
        }else {
            UserDefaults.standard.set(nil, forKey: "deliveryUser")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static func loadDeliveryUser() -> DeliveryUserResponse! {
        if let value = UserDefaults.standard.value(forKey: "deliveryUser") as? Data {
            if let user = try? JSONDecoder().decode(DeliveryUserResponse.self, from: value ) {
                return user
            }
        }
        return nil
    }
    
    
    
    
    //    static func addItemToLocalCart(item : Item){
    //
    //        var selectedItem = item
    //        var userCartItems = loadLocalCart()!
    //        var isContain = false
    //        var itemIndex = -1
    //        userCartItems.forEach { (fetchedItem) in
    //            if fetchedItem.mainId == item.mainId {
    //                isContain = true
    //            }
    //            itemIndex = itemIndex + 1
    //        }
    //
    //        if  isContain  {
    //            //  let newQuantity = (selectedItem.itemQuantity ?? 0) + 1
    //            //  userCartItems[itemIndex].itemQuantity = newQuantity
    //        }else{
    //            //  selectedItem.quantity = selectedItem.quantity! + 1
    //            selectedItem.itemQuantity = 1
    //            userCartItems.append(selectedItem)
    //        }
    //
    //        if let value = try? JSONEncoder().encode(userCartItems) {
    //            //  UserDefaults.standard.set([], forKey: "UserCart")
    //            UserDefaults.standard.set(value, forKey: "UserCart")
    //            UserDefaults.standard.synchronize()
    //        }else {
    //            UserDefaults.standard.set(nil, forKey: "UserCart")
    //            UserDefaults.standard.synchronize()
    //        }
    //
    //        NotificationCenter.default.post(name: Notification.Name(Constants.CART_UPDATE_NOTIFICATION), object: nil)
    //    }
    
    static func updateUserCart(list : [Item],completion : @escaping (()->())) {
        
        
        var userCartItems = loadLocalCart() ?? []
        
        if userCartItems.count == 0 {
            if list.count > 0 {
                userCartItems.append(contentsOf: list)
                addAllLocalCart(itemsList : userCartItems)
                completion()
            }
        }else{
            list.forEach { (item) in
                let index = userCartItems.firstIndex(of: item) ?? -1
                if item.storeId != userCartItems[0].storeId {
                    let clearMsg = (Strings.shared.clearCartMsg1) +   (userCartItems[0].storeName ?? "") + (Strings.shared.clearCartMsg2)
                    UIApplication.shared.windows[0].visibleViewController?.areYouSureMsg(Msg: clearMsg) { (yes) in
                        if yes{
                            userCartItems = []
                            userCartItems.append(item)
                            addAllLocalCart(itemsList : userCartItems)
                            completion()
                        }
                        
                    }
                    
                    
                    
                }else {
                    
                    if index != -1 {
                        //                    let totalQuantity = (userCartItems[index].itemQuantity ?? 0) + (item.itemQuantity ?? 0)
                        //         userCartItems[index].itemQuantity = totalQuantity
                        addAllLocalCart(itemsList : userCartItems)
                        completion()
                    }else{
                        
                        userCartItems.append(item)
                        addAllLocalCart(itemsList : userCartItems)
                        completion()
                    }
                }
            }
        }
        
        
        
    }
    
    
    static func deleteItemFromLocalCart(item : Item){
        
        let selectedItem = item
        var  userCartItems = loadLocalCart()!
        
        let itemIndex =  userCartItems.firstIndex(of: selectedItem) ?? -1
        userCartItems.remove(at: itemIndex)
        
        if let value = try? JSONEncoder().encode(userCartItems) {
            UserDefaults.standard.set(value, forKey: "UserCart")
            UserDefaults.standard.synchronize()
        }else {
            UserDefaults.standard.set(nil, forKey: "UserCart")
            UserDefaults.standard.synchronize()
        }
        
        NotificationCenter.default.post(name: Notification.Name(Constants.CART_UPDATE_NOTIFICATION), object: nil)
    }
    
    
    
    
    static func loadLocalCart() -> [Item]! {
        
        if let value = UserDefaults.standard.value(forKey: "UserCart") as? Data {
            if let userCart = try? JSONDecoder().decode([Item].self, from: value ) {
                return userCart
            }
        }
        return []
        
    }
    
    static func emptyLocalCart() {
        UserDefaults.standard.set(nil, forKey: "UserCart")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name(Constants.CART_UPDATE_NOTIFICATION), object: nil)
    }
    
    static func showResult(presenter: UIViewController, success: Bool, message: String?) {
           let title = success ? "Success" : "Failure"
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           presenter.present(alert, animated: true, completion: nil)
       }
    
    static func addAllLocalCart(itemsList : [Item]) {
        
        if let value = try? JSONEncoder().encode(itemsList) {
            UserDefaults.standard.set(value, forKey: "UserCart")
            UserDefaults.standard.synchronize()
        }else {
            UserDefaults.standard.set(nil, forKey: "UserCart")
            UserDefaults.standard.synchronize()
        }
        
        NotificationCenter.default.post(name: Notification.Name(Constants.CART_UPDATE_NOTIFICATION), object: nil)
    }
    
    
    
    
    
    
    
    //
    //    static func openWalkthroughScreen(){
    //        let vc = WalkthroughViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
    //        let nvc = UINavigationController(rootViewController: vc)
    //        nvc.navigationBar.isHidden = true
    //        UIApplication.shared.windows[0].rootViewController = nvc
    //        UIApplication.shared.windows[0].makeKeyAndVisible()
    //    }
    //
    
    //    static func openLoginScreen(){
    //      let nvc = UINavigationController(rootViewController: LoginRouter.createModule())
    //       nvc.navigationBar.isHidden = true
    //       UIApplication.shared.windows[0].rootViewController = nvc
    //      UIApplication.shared.windows[0].makeKeyAndVisible()
    //    }
    //
    //    static func openLandingScreen(){
    //       let vc = LandingViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
    ////        let vc = NearByEventsRouter.createModule()
    //        let nvc = UINavigationController(rootViewController: vc)
    //        nvc.navigationBar.isHidden = true
    //        UIApplication.shared.windows[0].rootViewController = nvc
    //        UIApplication.shared.windows[0].makeKeyAndVisible()
    //    }
    //
    
    //
    //    static func getNavigationController()->UINavigationController?{
    //        let root = (UIApplication.shared.windows[0].rootViewController)
    //        if root is UINavigationController{
    //            return root as? UINavigationController
    //        }else{
    //            return nil
    //        }
    //    }
    //
    //    static func getNotificationStatus()->Bool{
    //        if let status = UserDefaults.standard.value(forKey: Constants.NOTIFICATIONS) as? Bool{
    //            return status
    //        }
    //        return true
    //    }
    //
    
    
    
    //
    //    static func getLanguage() -> String
    //    {
    //        if let language = UserDefaults.standard.value(forKey: "current_language") as? String{
    //            return language
    //        }
    //        return "en"
    //    }
    //
    //    static func isUserLoggedIn() -> Bool {
    //        let user = UserDataSource.loadUser()
    //        let token = user?.token ?? ""
    //
    //        if token != "" {
    //
    //            return true
    //        }else{
    //            return false
    //        }
    //    }
    //
    //    static func appIsArabic()->Bool{
    //        return getLang() == "ar"
    //    }
    //
    //    static func getLang()->String{
    //        if let lang = UserDefaults.standard.value(forKey: "lang") as? String{
    //            return lang
    //        }else{
    //            print(Locale.preferredLanguages[0])
    //            let lang = Locale.preferredLanguages[0].contains("ar") ? "ar" : "en"
    //            UserDefaults.standard.set(lang, forKey: "lang")
    //            return lang
    //        }
    //    }
    //
    //    static func isNotificationOn() -> Bool {
    //        let notificationStatus = UserDefaults.standard.value(forKeyPath: CachingModel.CachingKeys.NOTIFICATION_STATUS) as? Bool ?? true
    //
    //        return notificationStatus
    //    }
    //
    //
    //    static func setNotificationStatus(){
    //
    //        let status = isNotificationOn()
    //        let notifcationStatus = status ? false : true
    //        UserDefaults.standard.set(notifcationStatus, forKey: CachingModel.CachingKeys.NOTIFICATION_STATUS)
    //
    //        if status {
    //        UIApplication.shared.registerForRemoteNotifications()
    //        }else{
    //        UIApplication.shared.unregisterForRemoteNotifications()
    //        }
    //   }
    //
    //    static func setFontSizeStatus(status : Int){
    //        if status == 0 {
    //            Constants.fontScale = 0.9
    //
    //        }else if status == 1 {
    //            Constants.fontScale = 1.0
    //        }else if status == 2 {
    //            Constants.fontScale = 1.1
    //        }
    //       UserDefaults.standard.set(status, forKey: CachingModel.CachingKeys.FONT_STATUS)
    //    }
    //
    //
    //    static func getFontSizeStatus() -> Int {
    //        let status =  UserDefaults.standard.string(forKey: CachingModel.CachingKeys.FONT_STATUS) ?? "1"
    //        return Int(status) ?? 1
    //    }
    //
    //    static func isFirstTime() -> Bool {
    //
    //      let status =  UserDefaults.standard.string(forKey: CachingModel.CachingKeys.FIRST_TIME) ?? "true"
    //      let currentStatus = Bool(status) ?? true
    //
    //        UserDefaults.standard.set("false", forKey: CachingModel.CachingKeys.FIRST_TIME)
    //
    //        return currentStatus
    //    }
    //
    //   static func addMatchToCalendar(match : Match) {
    //         let currentVc = UIApplication.shared.windows[0].visibleViewController
    //        let eventStore = EKEventStore()
    //
    //        switch EKEventStore.authorizationStatus(for: .event) {
    //        case .authorized:
    //            insertEvent(store: eventStore, match : match)
    //        case .denied:
    //           currentVc?.showMessage("Access denied".localize())
    //        case .notDetermined:
    //            // 3
    //            eventStore.requestAccess(to: .event, completion:
    //                { (granted: Bool, error: Error?) -> Void in
    //                    if granted {
    //                        self.insertEvent(store: eventStore,match: match)
    //                    } else {
    //                       currentVc?.showMessage("Access denied".localize())
    //                    }
    //            })
    //        default:
    //            print("Case default")
    //        }
    //    }
    //
    //  static func insertEvent(store: EKEventStore,match : Match) {
    //         let currentVc = UIApplication.shared.windows[0].visibleViewController
    //        let event = EKEvent(eventStore: store)
    //        event.title = match.competition?.name
    //        event.startDate = match.date?.toDate()
    //        event.endDate = match.date?.toDate()
    //        event.notes = match.competition?.description ?? "" + "  \(String(describing: match.homeTeam?.title))" + "  \(String(describing: match.awayTeam?.title))"
    //
    //        event.calendar = store.defaultCalendarForNewEvents
    //
    //        do {
    //            try store.save(event, span: .thisEvent)
    //             currentVc?.showMessage("Event added successfully to calendar".localize())
    //        }
    //        catch {
    //             currentVc?.showMessage("Error saving event in calendar".localize())
    //        }
    //    }
    //
    //    static func downloadBrochure(fileUrl : String){
    //
    //
    ////        let vc = BasicWebViewController.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
    ////        vc.fileUrl = fileUrl
    ////    UIApplication.shared.windows[0].visibleViewController?.present(vc, animated: true, completion: nil)
    ////
    ////
    //    }
    //
    //
    static func call (number : String){
        
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
    }
    //
    //    static func shareLink(vc : UIViewController,link : String) {
    //
    //        let textToShare = [URL.init(string: link)]
    //        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any],
    //                applicationActivities: nil)
    //        activityViewController.excludedActivityTypes = [.airDrop]
    //
    //        if let popoverController = activityViewController.popoverPresentationController {
    //            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2,
    //                    y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
    //            popoverController.sourceView = vc.view
    //            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
    //        }
    //        vc.present(activityViewController, animated: true, completion: nil)
    //
    //    }
    //
    static func openWebsite(link : String) {
        guard let url = URL(string: link) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    //
    //    static func openMail(email : String) {
    //        if let url = URL(string: "mailto:\(email)") {
    //            if #available(iOS 10.0, *) {
    //                UIApplication.shared.open(url)
    //            } else {
    //                UIApplication.shared.openURL(url)
    //            }
    //        }
    //    }
    //
    //    static func validateYouTubeLink(youtubeURL : String) -> Bool {
    //        let regex = "^((?:https?:)?\\/\\/)?((?:www|m)\\.)?((?:youtube\\.com|youtu.be))(\\/(?:[\\w\\-]+\\?v=|embed\\/|v\\/)?)([\\w\\-]+)(\\S+)?$"
    //
    //        let test = NSPredicate(format:"SELF MATCHES %@", regex)
    //        return test.evaluate(with: youtubeURL)
    //    }
    //
    //    static func getYoutubeImageLink(youtubeUrl: String) -> String? {
    //        if(youtubeUrl.youtubeID != nil){
    //            return "http://img.youtube.com/vi/"+youtubeUrl.youtubeID!+"/mqdefault.jpg"
    //        }
    //        else{
    //            return ""
    //        }
    //
    //    }
    //    static func getYoutubeVideoId(youtubeUrl: String) -> String? {
    //        return youtubeUrl.youtubeID!
    //    }
    //
    //
    
    static func openContentSheet(mVC : UIViewController) -> ContentSheet{
        let content: ContentSheetContentProtocol
        let mVC = mVC
        let contentController = mVC
        content = contentController
        let contentSheet = ContentSheet(content: content)
        contentSheet.blurBackground = false
        contentSheet.showDefaultHeader = false
        return contentSheet
    }
    
    
}
