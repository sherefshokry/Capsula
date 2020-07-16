//
//  TrackOrderViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import Intercom

class TrackOrderViewController : UIViewController {
    
    private let provider = MoyaProvider<CheckOutDataSource>()
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var estimatedDateLabel : UILabel!
    @IBOutlet weak var estimatedTimeLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    var order = Order()
    var orderTrackingList = [OrderTrack]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrderTrackingData()
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           topView.clipsToBounds = true
           topView.layer.cornerRadius = 70
           topView.layer.maskedCorners = [.layerMinXMaxYCorner]
       }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              
              if Utils.loadUser()?.accessToken ?? "" != "" {
                 Intercom.setLauncherVisible(true)
              }
          }
      
    
    
    func getOrderTrackingData() {
        
        KVNProgress.show()
        provider.request(.orderTrackingList(order.id ?? -1)) { [weak self] result in
               KVNProgress.dismiss()
               guard let self = self else { return }
               switch result {
               case .success(let response):
                   do {
                    let orderTrackingResponse = try response.map(BaseResponse<OrderTrackingResponse>.self)
                    self.orderTrackingList = orderTrackingResponse.data?.orderList ?? []
                    if self.orderTrackingList.count > 0 {
                        self.estimatedDateLabel.text = self.orderTrackingList[0].operationDate?.monthFormat()
                        
                        self.estimatedTimeLabel.text = self.orderTrackingList[0].operationDate?.timeFormat()
                    }
                    
                    
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
extension TrackOrderViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderTrackingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier, for: indexPath) as! TrackCell
        cell.setData(track: orderTrackingList[indexPath.row])
        return cell
    }
    
    
    
    
    
    
    
    
    
}
