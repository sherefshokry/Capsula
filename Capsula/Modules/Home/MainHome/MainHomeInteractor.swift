//
//  MainHomeInteractor.swift
//  Capsula
//
//  Created SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Moya

class MainHomeInteractor : PresenterToIntetractorMainHomeProtocol {
    
    var presenter: InteractorToPresenterMainHomeProtocol?
    private let provider = MoyaProvider<HomeDataSource>()
    private let storesProvider = MoyaProvider<StoresDataSource>()
    private let userProvivider = MoyaProvider<AuthDataSource>()
    var fetchedData = [Store]()
    var allStores = [Store]()
    
    
    func  getStoresData(page : Int) {
          storesProvider.request(.getStoresData(page)) { [weak self] result in
               guard let self = self else { return }
               switch result {
               case .success(let response):
                   do {
                    let storesResponse = try response.map(BaseResponse<StoresResponse>.self)
                    
                    self.fetchedData = storesResponse.data?.storesList ?? []
                    self.handleStoresPagination()
               
                   } catch(let catchError) {
                       self.presenter?.storesDataFailedToFetch(error: catchError.localizedDescription)
                   }
               case .failure(let error):
                   do{
                       if let body = try error.response?.mapJSON(){
                           let errorData = (body as! [String:Any])
                           self.presenter?.storesDataFailedToFetch(error: (errorData["errors"] as? String) ?? "")
                       }
                   }catch{
                       self.presenter?.storesDataFailedToFetch(error: error.localizedDescription)
                   }
               }
           }
           
       }
      
    func updateUserData() {
        provider.request(.updateUserData) { [weak self] result in
              guard let self = self else { return }
              switch result {
              case .success(let response):
                  do {
                    let userResponse = try response.map(BaseResponse<User>.self).data ?? User()
                      var updatedUser = Utils.loadUser() ?? UserResponse()
                     updatedUser.user = userResponse
                    
                    Utils.saveUser(user: updatedUser)
                    if updatedUser.user?.cartContent?.count ?? 0 > 0 {
                         Utils.emptyLocalCart()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        Utils.updateUserCart(list: updatedUser.user?.cartContent ?? []) {
                    }
                    }
                  } catch(let catchError) {
                      self.presenter?.homeDataFailedToFetch(error: catchError.localizedDescription)
                  }
              case .failure(let error):
                  do{
                      if let body = try error.response?.mapJSON(){
                          let errorData = (body as! [String:Any])
//                          self.presenter?.homeDataFailedToFetch(error: (errorData["errors"] as? String) ?? "")
                      }
                  }catch{
//                      self.presenter?.homeDataFailedToFetch(error: error.localizedDescription)
                  }
              }
          }
          
      }
    
    
    
    func  refreshDevice() {
        userProvivider.request(.refreshDevice) { [weak self] result in
               guard let self = self else { return }
               switch result {
               case .success(_):
                
                break
               case .failure(let error):
                
                break
               
               }
           }
           
       }
    
    
    func handleStoresPagination()  {
       
        if self.fetchedData.count < Constants.per_page {
             self.presenter?.stopPagination()
         }
         allStores.append(contentsOf: fetchedData)
         self.presenter?.storesDataFetchedSuccessfully(storesResponse: allStores)
     }
    
     
    

}

