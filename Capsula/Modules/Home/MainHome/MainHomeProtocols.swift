//
//  MainHomeProtocols.swift
//  Capsula
//
//  Created SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit

protocol ViewToPresenterMainHomeProtocol: class {
    var view : PresenterToViewMainHomeProtocol? {get set}
    var interactor : PresenterToIntetractorMainHomeProtocol? {get set}
    var router : PresenterToRouterMainHomeProtocol? {get set}
    var  page : Int { get }
    var  numberOfRows : Int { get }
    func configureStoreCell(cell : StoreCell , indexPath : IndexPath)
    func getStoresData()
    func refreshDevice()
    func viewDidLoad()
    func didSelectStore(indexPath : IndexPath)
    func loadPagingData(indexPath : IndexPath)
    
}

protocol PresenterToViewMainHomeProtocol: class {
     func changeState(state :  State)
}

protocol PresenterToIntetractorMainHomeProtocol: class {
     var presenter: InteractorToPresenterMainHomeProtocol? { get set }
     func  getStoresData(page: Int)
     func  updateUserData()
     func  refreshDevice()
    
}

protocol PresenterToRouterMainHomeProtocol: class  {
     static func createModule() -> UIViewController
     func openCategoriesScreen(from sourceView: PresenterToViewMainHomeProtocol?,storeId : Int)
}

protocol InteractorToPresenterMainHomeProtocol: class {
    func  storesDataFetchedSuccessfully(storesResponse: [Store])
    func  storesDataFailedToFetch(error : String)
    func  homeDataFailedToFetch(error: String)
    func stopPagination()
}
