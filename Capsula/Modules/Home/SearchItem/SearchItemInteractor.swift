//
//  SearchItemInteractor.swift
//  Capsula
//
//  Created SherifShokry on 2/24/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Moya
class SearchItemInteractor : PresenterToIntetractorSearchItemProtocol {
   
    var presenter: InteractorToPresenterSearchItemProtocol?
    private let provider = MoyaProvider<ItemsDataSource>()
    private let cartProvider = MoyaProvider<CartDataSource>()
    var fetchedData = [Item]()
    var allItems = [Item]()
    
    func itemsSearch(searchText: String, filterType: Int,page: Int) {
        
        provider.request(.itemsSearch(searchText, filterType, page)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    do {
                        let itemsResponse = try response.map(BaseResponse<ItemsResponse>.self)
                        self.fetchedData = itemsResponse.data?.itemsList ?? []
                        self.handleItemsPagination()
                    
                    } catch(let catchError) {
                        self.presenter?.itemsDataFailedToFetch(error: catchError.localizedDescription)
                    }
                case .failure(let error):
                    do{
                        if let body = try error.response?.mapJSON(){
                            let errorData = (body as! [String:Any])
                            self.presenter?.itemsDataFailedToFetch(error: (errorData["errors"] as? String) ?? "")
                        }
                    }catch{
                        self.presenter?.itemsDataFailedToFetch(error: error.localizedDescription)
                    }
                }
            }
        
    }
    
   
    
    func addItemsToCart(itemData : Item){
          var cartItemsList = [CartItem]()
          var cartItem = CartItem()
          cartItem.mainId = itemData.mainId ?? -1
          cartItem.quantity = itemData.itemQuantity ?? 1
          cartItemsList.append(cartItem)
            
          cartProvider.request(.addCart(cartItemsList)) { [weak self] result in
              guard let self = self else { return }
                  switch result {
                              case .success(let response):
                                     do {
                              let itemsResponse = try response.map(BaseResponse<ItemsResponse>.self)
                              self.presenter?.itemsDataAddedToCartSuccessfully(itemsResponse: itemsResponse.data?.itemsList ?? [])
                                     } catch(let catchError) {
                                         self.presenter?.itemsDataFailedToFetch(error: catchError.localizedDescription)
                                     }
                                 case .failure(let error):
                                     do{
                                         if let body = try error.response?.mapJSON(){
                                             let errorData = (body as! [String:Any])
                                             self.presenter?.itemsDataFailedToFetch(error: (errorData["errors"] as? String) ?? "")
                                         }
                                     }catch{
                                         self.presenter?.itemsDataFailedToFetch(error: error.localizedDescription)
                                     }
                                 }
                             }
           }
      
    func handleItemsPagination()  {
        if self.fetchedData.count < Constants.per_page {
             self.presenter?.stopPagination()
         }
         allItems.append(contentsOf: fetchedData)
         self.presenter?.itemsDataFetchedSuccessfully(itemsResponse: allItems)
     }
    
    func emptyAllItems(){
           allItems = []
       }
    
}

