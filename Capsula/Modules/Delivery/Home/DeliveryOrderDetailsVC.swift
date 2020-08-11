//
//  DeliveryOrderDetailsVC.swift
//  Capsula
//
//  Created by SherifShokry on 7/4/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import Intercom

class DeliveryOrderDetailsVC : UIViewController {
    
    private let provider = MoyaProvider<DeliveryManDataSource>()
    @IBOutlet weak var topView:  UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var paymentMethodType: UILabel!
    @IBOutlet weak var itemsCost : UILabel!
    @IBOutlet weak var deliveryCost : UILabel!
    @IBOutlet weak var totalPrice : UILabel!
    @IBOutlet weak var collectionViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var startOrderBtn : UIButton!
    @IBOutlet weak var finishOrderBtn : UIButton!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var phoneNumberLabel : UILabel!
    
    var ordersList = [Item]()
    var order = DeliveryOrder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrderDetailsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           Intercom.setLauncherVisible(false)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cartView.clipsToBounds = true
        cartView.layer.cornerRadius = 20
        cartView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    func getOrderDetailsData() {
        KVNProgress.show()
        provider.request(.getOrderDetails(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let ordersDetailsResponse = try response.map(BaseResponse<DeliveryOrderDetailsResponse>.self)
                    
                    self.setData(ordersDetailsResponse : ordersDetailsResponse.data ?? DeliveryOrderDetailsResponse())
                    
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
    
    func setData(ordersDetailsResponse : DeliveryOrderDetailsResponse){
        
        
        let orderStatus =  ordersDetailsResponse.statusId ?? -1
        
        if orderStatus == 1 {
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            finishOrderBtn.isHidden = true
            finishOrderBtn.isEnabled = false
            startOrderBtn.isHidden = false
            startOrderBtn.isEnabled = true
        }else if (orderStatus == 2) {
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            finishOrderBtn.isHidden = false
            finishOrderBtn.isEnabled = true
            startOrderBtn.isHidden = true
            startOrderBtn.isEnabled = false
        }else{
            cartViewHeightConstraint.constant = 0
            cartView.isHidden = true
        }
        
        
        switch  (ordersDetailsResponse.paymentMethodId ?? 0) {
        case 1:
            paymentMethodType.text = Strings.cash
            break
        case 2:
            paymentMethodType.text = Strings.applePay
            break
        case 3:
            paymentMethodType.text = Strings.stcPay
            break
        case 4:
            paymentMethodType.text = Strings.creditCard
            break
        case 5:
            paymentMethodType.text = Strings.madaPay
            break
        case 6:
            paymentMethodType.text = Strings.googlePay
            break
        default:
            print("No thing to do")
        }
        
        itemsCost.text = Strings.RSD + " \(ordersDetailsResponse.itemsCost ?? 0.0)"
        deliveryCost.text = Strings.RSD + " \(ordersDetailsResponse.vatCost ?? 0.0)"
        totalPrice.text = Strings.RSD + " \(ordersDetailsResponse.finalTotalCost ?? 0.0)"
        //Delivery cost to be handle
        
        self.ordersList = ordersDetailsResponse.products ?? []
        self.addressLabel.text = ordersDetailsResponse.customerAddress ?? ""
        self.phoneNumberLabel.text = "+96" + (ordersDetailsResponse.phoneNumber ?? "")
        let rows : Float  = Float(ordersList.count / 2)
        var totalNumberOfRows : CGFloat = 0.0
        if rows == 0 {
            totalNumberOfRows = 1.0
        }else{
            totalNumberOfRows = CGFloat(ceil(Float(rows)))
        }
        
        let collectionWidth = (self.collectionView.bounds.width / 2.0)
        let rowHeight = collectionWidth + 20
        
        
        
        self.collectionViewHeightConstraint.constant = CGFloat(totalNumberOfRows) * rowHeight
        self.view.layoutIfNeeded()
        self.collectionView.reloadData()
        
        
    }
    
    
    
    @IBAction func startOrderPressed(_ sender : UIButton){
        KVNProgress.show()
        provider.request(.startDelivery(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.dismiss(animated: true) {
                    self.openGoogleMap()
                    NotificationCenter.default.post(name: Notification.Name(Constants.RELOAD_DELIVERY_MAN_ORDERS_LIST), object: nil)
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
    
    
    @IBAction func finishOrderPressed(_ sender : UIButton){
        KVNProgress.show()
        provider.request(.finishDelivery(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: Notification.Name(Constants.RELOAD_DELIVERY_MAN_ORDERS_LIST), object: nil)
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
    
    
    
    func openGoogleMap() {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(order.customerLat ?? 0.0),\(order.customerLong ?? 0.0)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }}
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(order.customerLat ?? 0.0),\(order.customerLong ?? 0.0)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
        
    }
    
    
    
    
    
    
}


extension DeliveryOrderDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailsCell.identifier, for: indexPath) as! ProductDetailsCell
        cell.setData(item: ordersList[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 2.0)
        let height = width + 20.0
        
        return CGSize(width: width, height: height)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
}
