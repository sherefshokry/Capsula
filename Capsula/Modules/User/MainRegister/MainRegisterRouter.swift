//
//  MainRegisterRouter.swift
//  Capsula
//
//  Created SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MainRegisterRouter : PresenterToRouterMainRegisterProtocol {
    
    
    
    
    static func createModule(isDeliveryMan : Bool) -> UIViewController {
        
        let view = MainRegisterViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
        view.isDeliveryMan = isDeliveryMan 
        let presenter : ViewToPresenterMainRegisterProtocol & InteractorToPresenterMainRegisterProtocol = MainRegisterPresenter()
        let interactor : PresenterToIntetractorMainRegisterProtocol = MainRegisterInteractor()
        let router : PresenterToRouterMainRegisterProtocol = MainRegisterRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    
    func openCompleteProfile(from sourceView: PresenterToViewMainRegisterProtocol?, user: User,fromApple : Bool) {
        let vc = CompleteProfileRouter.createModule(user: user, fromApple: fromApple)
                if let sourceView = sourceView as? UIViewController {
                    sourceView.present(vc, animated: true, completion: nil)
                }
    }
    
    func openAddAddress(from sourceView: PresenterToViewMainRegisterProtocol?) {
        
        let vc = AddAddressViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
        vc.openHomeScreen = true
        if let sourceView = sourceView as? UIViewController {
            sourceView.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    
    
}
