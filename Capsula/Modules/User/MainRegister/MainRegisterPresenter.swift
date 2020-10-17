//
//  MainRegisterPresenter.swift
//  Capsula
//
//  Created SherifShokry on 12/28/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

class MainRegisterPresenter : ViewToPresenterMainRegisterProtocol{
  
    
    
    var view: PresenterToViewMainRegisterProtocol?
    var interactor: PresenterToIntetractorMainRegisterProtocol?
    var router: PresenterToRouterMainRegisterProtocol?
    
    func loginWithFacebook(token: String) {
        self.view?.changeState(state: .loading)
        self.interactor?.loginWithFacebook(token : token)
    }
    
    func loginWithGoogle(token: String) {
        self.view?.changeState(state: .loading)
        self.interactor?.loginWithGoogle(token : token)
    }
    
    func loginWithTwitter(token: String, secretKey: String) {
        self.view?.changeState(state: .loading)
        self.interactor?.loginWithTwitter(token : token, secretKey: secretKey)
    }
    
    func loginWithApple(name: String, email: String) {
           self.view?.changeState(state: .loading)
           self.interactor?.loginWithApple(name: name, email: email)
      }
      
    
}


extension MainRegisterPresenter : InteractorToPresenterMainRegisterProtocol {
    func loggedInSuccussfully(userResponse: UserResponse) {
        
        self.view?.changeState(state: .ready)
        if userResponse.user?.phone ?? "" == "" {
            self.router?.openCompleteProfile(from: self.view, user: userResponse.user ?? User())
        }else{
            Utils.saveUser(user: userResponse)
            if userResponse.user?.addressList?.count == 0 {
                self.router?.openAddAddress(from: self.view)
            }else{
                Utils.openHomeScreen()
            }
        }
    }
    
    func failedToLogin(error: String) {
        
        
        self.view?.changeState(state: .error(error))
    }
    
    
}

