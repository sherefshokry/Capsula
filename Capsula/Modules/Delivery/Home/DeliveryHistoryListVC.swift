//
//  DeliveryHistoryVC.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import ContentSheet
import Intercom


class DeliveryHistoryListVC : UIViewController {
    
    @IBOutlet weak var topView  : UIView!
    @IBOutlet weak var tableView : UITableView!
    var deliveryOrdersList = [DeliveryOrder]()
    private let provider = MoyaProvider<DeliveryManDataSource>()
    var filteredDate = Date().toFilterString()
    override func viewDidLoad() {
        super.viewDidLoad()
       getFilteredOrdersListData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    

    
    func getFilteredOrdersListData() {
         KVNProgress.show()
        provider.request(.getFilteredOrdersHistory(filteredDate)) { [weak self] result in
             KVNProgress.dismiss()
             guard let self = self else { return }
             switch result {
             case .success(let response):
                 do {
                     let ordersResponse = try response.map(BaseResponse<DeliveryOrdersResponse>.self)
                     self.deliveryOrdersList = ordersResponse.data?.ordersList ?? []
                     self.tableView.reloadData()
                 } catch(let catchError) {
                     self.showMessage(catchError.localizedDescription)
                 }
             case .failure(let error):
                 do{
                     if let body = try error.response?.mapJSON(){
                         let errorData = (body as! [String:Any])
                         self.showMessage((errorData["errors"] as? String) ?? "")
                         
                     }
                 }catch{
                     self.showMessage(error.localizedDescription)
                 }
             }
         }
         
     }
    
    
    
    
    @IBAction func filterPressed(_ sender : UIButton){
        
        let content: ContentSheetContentProtocol
        let vc = DeliveryFilterHistoryOrdersVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        
        vc.applyFilterPressed = { filterDate in
                self.filteredDate = filterDate
                self.getFilteredOrdersListData()
            }
        
        let contentController = vc
        content = contentController
        let contentSheet = ContentSheet(content: content)
        contentSheet.blurBackground = false
        contentSheet.showDefaultHeader = false
        self.present(contentSheet, animated: true, completion: nil)
        
        
    }
    
    
    
    
}


extension DeliveryHistoryListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  deliveryOrdersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOrderCell.identifier, for: indexPath) as! DeliveryOrderCell
        cell.setData(order: deliveryOrdersList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeliveryOrderDetailsVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        vc.order =  deliveryOrdersList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}
