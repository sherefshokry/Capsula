//
//  DeliveryHomeVC.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import KVNProgress
import Moya
import ViewAnimator
import Intercom

class DeliveryHomeVC : UIViewController {
    let transition = CircularTransition()
    @IBOutlet weak var homeTapView : UIView!
    @IBOutlet weak var moreTapView : UIView!
    @IBOutlet weak var tableView   : UITableView!
    var refreshControl = UIRefreshControl()
    var ordersList = [DeliveryOrder]()
//    var page : Int = 0
//    var isFinishedPaging = false
    private let provider = MoyaProvider<DeliveryManDataSource>()
    private let userProvivider = MoyaProvider<AuthDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: HomeDeliveryHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: HomeDeliveryHeaderCell.identifier)
        //  refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        //   tableView.addSubview(refreshControl)
        getMyOrders()
        refreshDevice()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadOrderList(_:)), name: NSNotification.Name(rawValue: Constants.RELOAD_DELIVERY_MAN_ORDERS_LIST), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshDeliveryData(_:)), name: NSNotification.Name(rawValue: Constants.REFRESH_DELIVERY_DATA), object: nil)
        
    }
    
    //    @objc func refresh(_ sender: AnyObject) {
    //       getMyOrders()
    //    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    @objc func reloadOrderList(_ notification: NSNotification){
//        page = 0
//        isFinishedPaging = false
//        ordersList = []
        getMyOrders()
    }
    
    @objc func refreshDeliveryData(_ notification: NSNotification){
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //   homeTapView.clipsToBounds = true
        homeTapView.layer.cornerRadius = 45
        homeTapView.layer.maskedCorners = [.layerMaxXMinYCorner]
        //  moreTapView.clipsToBounds = true
        moreTapView.layer.cornerRadius = 45
        moreTapView.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    @IBAction func morePressed(){
        let vc = SideMenuRouter.createModule()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func openNotificationScreen(_ sender : UIButton){
        let vc = NotificationListVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func loadPagingData(indexPath : IndexPath){
//              let count = ordersList.count
//              let newsCount = (count - 1)
//               if indexPath.row == newsCount && !isFinishedPaging {
//
//                  self.getMyOrders()
//              }
    }
    
    func  getMyOrders(){
        // if !refreshControl.isRefreshing {
        KVNProgress.show(withStatus: "", on: self.view)
        //}
//        let count = ordersList.count
//        page =  ( count / Constants.per_page ) + 1
//
        provider.request(.getOrdersList) { [weak self] result in
            KVNProgress.dismiss()
            // self?.refreshControl.endRefreshing()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let ordersResponse = try response.map(BaseResponse<DeliveryOrdersResponse>.self)
                  ///  let fetchedData = ordersResponse.data?.ordersList ?? []
//                    if fetchedData.count < Constants.per_page {
//                        self.isFinishedPaging = true
//                    }
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
    
    
}
extension DeliveryHomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let orderListCount = ordersList.count + 1
        return orderListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeDeliveryHeaderCell.identifier, for: indexPath) as! HomeDeliveryHeaderCell
            cell.openNotificationPressed = {
                let vc = NotificationListVC.instantiateFromStoryBoard(appStoryBoard: .Home)
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOrderCell.identifier, for: indexPath) as! DeliveryOrderCell
            let index = indexPath.row - 1
            cell.setData(order: ordersList[index])
            return cell
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row > 0 {
            
            let vc = DeliveryOrderDetailsVC.instantiateFromStoryBoard(appStoryBoard: .Home)
            let index = indexPath.row - 1
            vc.order =  ordersList[index]
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      //   self.loadPagingData(indexPath: indexPath)
    }
    
    
    
    
}


extension DeliveryHomeVC : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: 0, y: 0)
        transition.circleColor = UIColor.init(codeString: "#0E518A")
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint.init(x: 0, y: 0)
        transition.circleColor = UIColor.init(codeString: "#37B6FF")
        return transition
    }
}
