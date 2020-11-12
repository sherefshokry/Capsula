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
    @IBOutlet weak var productDetailsLabel : UILabel!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var storeAddressBtn: UIButton!
    @IBOutlet weak var deliveryAddressBtn: UIButton!
    
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
        
        if (orderStatus == 5) {
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            deliveryAddressBtn.isUserInteractionEnabled = true
            storeAddressBtn.isUserInteractionEnabled = true
            finishOrderBtn.isHidden = false
            finishOrderBtn.isEnabled = true
            startOrderBtn.isHidden = true
            startOrderBtn.isEnabled = false
        }else if (orderStatus == 6){
            //Delivered
            cartViewHeightConstraint.constant = 0
            cartView.isHidden = true
        }
        else{
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            finishOrderBtn.isHidden = true
            finishOrderBtn.isEnabled = false
            startOrderBtn.isHidden = false
            startOrderBtn.isEnabled = true
        }
        
    
        switch  (ordersDetailsResponse.paymentMethodId ?? 0) {
        case 1:
            paymentMethodType.text = Strings.shared.cash
            break
        case 2:
            paymentMethodType.text = Strings.shared.applePay
            break
        case 3:
            paymentMethodType.text = Strings.shared.stcPay
            break
        case 4:
            paymentMethodType.text = Strings.shared.creditCard
            break
        case 5:
            paymentMethodType.text = Strings.shared.madaPay
            break
        case 6:
            paymentMethodType.text = Strings.shared.googlePay
            break
        default:
            print("No thing to do")
        }
        
        itemsCost.text =  "\(ordersDetailsResponse.itemsCost ?? 0.0) " + Strings.shared.RSD
        
        deliveryCost.text = "\(ordersDetailsResponse.vatCost ?? 0.0) " + Strings.shared.RSD
        
        
        totalPrice.text = "\(ordersDetailsResponse.finalTotalCost ?? 0.0) " + Strings.shared.RSD
        
        
        self.ordersList = ordersDetailsResponse.products ?? []
        self.addressLabel.text = ordersDetailsResponse.customerAddress ?? ""
        self.phoneNumberLabel.text = ordersDetailsResponse.storeAddress ?? ""
        let rows : Float  = Float(ordersList.count / 2)
        var totalNumberOfRows : CGFloat = 0.0
        if rows == 0 {
            totalNumberOfRows = 1.0
        }else{
            totalNumberOfRows = CGFloat(ceil(Float(rows)))
        }
        
        let collectionWidth = (self.collectionView.bounds.width / 2.0)
        let rowHeight = collectionWidth + 20
        
        if ordersList.count > 0 {
            collectionView.isHidden = false
            productDetailsLabel.isHidden = false
            self.collectionViewHeightConstraint.constant = CGFloat(totalNumberOfRows) * rowHeight
        }else{
            collectionView.isHidden = true
            productDetailsLabel.isHidden = true
        }
        
        self.view.layoutIfNeeded()
        self.collectionView.reloadData()
        
        
    }
    
    @IBAction func onRefreshPressed(_ sender : UIButton){
          getOrderDetailsData()
    }
    
    @IBAction func startOrderPressed(_ sender : UIButton){
        KVNProgress.show()
        provider.request(.startDelivery(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.storeAddressBtn.isUserInteractionEnabled = true
                self.deliveryAddressBtn.isUserInteractionEnabled = true
                self.dismiss(animated: true) {
                    self.openGoogleMap(latitude: self.order.storeLat ?? 0.0, longitude: self.order.storeLong ?? 0.0)
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
    
    
    @IBAction func openDeliveryAddressOnMap(_ sender : UIButton){
      self.openGoogleMap(latitude: self.order.customerLat ?? 0.0, longitude: self.order.customerLong ?? 0.0)
    }
    
    @IBAction func openStoreAddressOnMap(_ sender : UIButton){
         self.openGoogleMap(latitude: self.order.storeLat ?? 0.0, longitude: self.order.storeLong ?? 0.0)
       }
    
    
    func openGoogleMap(latitude: Double , longitude: Double) {
      
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(order.customerLat ?? 0.0),\(order.customerLong ?? 0.0)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }}
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
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
