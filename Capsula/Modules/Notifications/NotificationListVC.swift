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
    var notificationData = [UserNotification]()
    
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
        
        var targetType  = -1
        if notificationData.count > 0  {
            targetType = notificationData[indexPath.row].type ?? -1
        }
        
        switch targetType {
        case -1:
            print("general notification")
            break
        case 5:
            let item = notificationData[indexPath.row].product ?? Item()
            let vc = ItemDetailsRouter.createModule(item: item)
            self.present(vc, animated: true, completion: nil)
            break
        case 6:
            self.dismiss(animated: true) {
                 NotificationCenter.default.post(name: Notification.Name(Constants.RELOAD_DELIVERY_MAN_ORDERS_LIST), object: nil)
            }
            break
        case 7:
            let vc = TrackOrderViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
            var dummyOrder = Order()
            dummyOrder.id = notificationData[indexPath.row].orderId ?? -1
            vc.order = dummyOrder
            self.present(vc, animated: true, completion: nil)
            break
        default:
            print("no thing to do :)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
}
