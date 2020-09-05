//
//  SideMenuInteractor.swift
//  Capsula
//
//  Created SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Intercom
class SideMenuInteractor : PresenterToIntetractorSideMenuProtocol {
    
    var presenter: InteractorToPresenterSideMenuProtocol?
    
    func logOut() {
        
        Utils.saveDeliveryUser(user: nil)
        Utils.saveUser(user: nil)
        Utils.openWelcomeScreen()
        Intercom.logout()
        
        //          provider.request(.logOut) { [weak self] result in
        //              guard let self = self else { return }
        //             switch result {
        //             case .success(let _):
        //                self.presenter?.logOutSuccessfully()
        //              break
        //             case .failure(let error):
        //              do{
        //                if let body = try error.response?.mapJSON(){
        //                    let errorData = (body as! [String:Any])
        //                    self.presenter?.faildToLogout(error: (errorData["error"] as? String) ?? "")
        //            }
        //                }catch{
        //                self.presenter?.faildToLogout(error: error.localizedDescription)
        //                }
        //              break
        //             }
        //           }
    }
    
    
    func getSideMenuItemsForUser() -> [SideMenu] {
        var sideMenuItems = [SideMenu]()
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Profile, elementIcon : #imageLiteral(resourceName: "icPersonal")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.MyOrders, elementIcon : UIImage(named: "icTrack") ?? UIImage()))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Payment, elementIcon : #imageLiteral(resourceName: "icPayment")))
        
        //        sideMenuItems.append(
        //            SideMenu.init(elementText: Strings.SideMenu.shared.Help, elementIcon : #imageLiteral(resourceName: "icHelp")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.About, elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Terms, elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Notifications , elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.FAQ, elementIcon :  #imageLiteral(resourceName: "icFaqs")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Language, elementIcon : #imageLiteral(resourceName: "icLanguage")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Logout, elementIcon :  #imageLiteral(resourceName: "icLogout")))
        
        
        return sideMenuItems
    }
    
    
    func getSideMenuItemsForGuestUser() -> [SideMenu] {
        var sideMenuItems = [SideMenu]()
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Help, elementIcon : #imageLiteral(resourceName: "icHelp")))
        
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Notifications , elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.About, elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Terms, elementIcon : #imageLiteral(resourceName: "icNotifications")))
        
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.FAQ, elementIcon :  #imageLiteral(resourceName: "icFaqs")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Language, elementIcon : #imageLiteral(resourceName: "icLanguage")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.LogIn, elementIcon :  #imageLiteral(resourceName: "icLogout")))
        
        
        return sideMenuItems
    }
    
    
    
    func getSideMenuItemsForDeliveryMan() -> [SideMenu] {
        var sideMenuItems = [SideMenu]()
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Profile, elementIcon : #imageLiteral(resourceName: "icPersonal")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.History, elementIcon : #imageLiteral(resourceName: "icHistory")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.MyWallet, elementIcon : #imageLiteral(resourceName: "icWallet")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Language, elementIcon : #imageLiteral(resourceName: "icLanguage")))
        
        sideMenuItems.append(
            SideMenu.init(elementText: Strings.SideMenu.shared.Logout, elementIcon :  #imageLiteral(resourceName: "icLogout")))
        
        return sideMenuItems
    }
    
    
    
    
    
    func navigate(item: SideMenu) {
        
        switch item.elementText {
        case Strings.SideMenu.shared.MyOrders:
            let vc = OrderListViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.Payment:
            self.presenter?.openPaymentScreen()
            break
            
        case Strings.SideMenu.shared.FAQ:
            let vc = FAQViewController.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.Language:
            self.presenter?.selectLanguage()
            break
        case Strings.SideMenu.shared.MyWallet:
            let vc =  DeliveryManWalletVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.Terms:
            let vc = TermsAndConditionsVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.About:
            let vc =  AboutUsVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.History:
            print("History")
            let vc = DeliveryHistoryListVC.instantiateFromStoryBoard(appStoryBoard: .Home)
            self.presenter?.navigate(viewController: vc, animation: true)
            break
        case Strings.SideMenu.shared.Logout:
            logOut()
            break
        case Strings.SideMenu.shared.LogIn:
            Utils.openWelcomeScreen()
            break
            
        case Strings.SideMenu.shared.Profile:
            let isDeliveryMan = UserDefaults.standard.bool(forKey: "isDelivery")
            if isDeliveryMan {
                let vc = DeliveryManProfileVC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
                self.presenter?.navigate(viewController: vc, animation: true)
            }else{
                let vc = UserProfileViewController.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
                self.presenter?.navigate(viewController: vc, animation: true)
            }
            break
        default:
            print("No thing to do :D")
        }
        
    }
    
    
    
    
    
    
    
    
    
}

