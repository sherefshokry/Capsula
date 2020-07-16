//
//  OrderListViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import Intercom

class OrderListViewController : UIViewController {
    
    private let provider = MoyaProvider<CheckOutDataSource>()
    @IBOutlet weak var topView  : UIView!
    @IBOutlet weak var tableView : UITableView!
    var ordersList = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          getOrdersListData()
          NotificationCenter.default.addObserver(self, selector: #selector(self.reloadOrderList(_:)), name: NSNotification.Name(rawValue: Constants.RELOAD_ORDERS_LIST), object: nil)
    }
    
       @objc func reloadOrderList(_ notification: NSNotification){
          getOrdersListData()
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if Utils.loadUser()?.accessToken ?? "" != "" {
               Intercom.setLauncherVisible(true)
            }
        }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    
    func getOrdersListData() {
        KVNProgress.show()
        provider.request(.ordersList) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let ordersResponse = try response.map(BaseResponse<OrdersResponse>.self)
                    self.ordersList = ordersResponse.data?.ordersList ?? []
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
    
}
extension OrderListViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier , for: indexPath) as! OrderCell
        cell.moreDetails = { selectedOrder in
         
            let vc = OrderDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
            vc.order = selectedOrder
            self.present(vc, animated: true, completion: nil)
            
        }
        cell.setData(order: ordersList[indexPath.row])
        return cell
    }
    

}
