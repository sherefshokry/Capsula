//
//  NotificationListVC.swift
//  Capsula
//
//  Created by SherifShokry on 9/23/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Moya
import KVNProgress

class NotificationListVC: UIViewController {
    
    private let provider = MoyaProvider<UserDataSource>()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var emptyView : UIStackView!
    var notificationData = [UserNotification()]

    override func viewDidLoad() {
        super.viewDidLoad()
        getNotificationsData()
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
         topView.clipsToBounds = true
         topView.layer.cornerRadius = 70
         topView.layer.maskedCorners = [.layerMinXMaxYCorner]
     }
    
    func getNotificationsData() {
        KVNProgress.show()
        provider.request(.getNotifications) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
            let notificationsResponse = try response.map(BaseResponse<NotificationResponse>.self)
                    
                    self.notificationData = notificationsResponse.data?.notificationsList ?? []
                    self.tableView.reloadData()
                    if self.notificationData.count == 0{
                        self.emptyView.isHidden = false
                    }else{
                        self.emptyView.isHidden = true
                    }
                    
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
extension NotificationListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as! NotificationCell
        cell.setData(notificationItem: notificationData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
}
