//
//  ResetPasswordRouter.swift
//  Capsula
//
//  Created SherifShokry on 1/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit


    class ResetPasswordRouter : PresenterToRouterResetPasswordProtocol {
        
        static func createModule() -> UIViewController {
            
            let view = ResetPasswordViewController.instantiateFromStoryBoard(appStoryBoard: /*replace with storyboard name*/)
            let presenter : ViewToPresenterResetPasswordProtocol & InteractorToPresenterResetPasswordProtocol = ResetPasswordPresenter()
            let interactor : PresenterToIntetractorResetPasswordProtocol = ResetPasswordInteractor()
            let router : PresenterToRouterResetPasswordProtocol = ResetPasswordRouter()
            
            view.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            presenter.router = router
            interactor.presenter = presenter
            return view
        }
    }