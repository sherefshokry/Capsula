//
//  OrderDetailsViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/25/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
import UIKit
import KVNProgress
import Moya
import Intercom

class OrderDetailsViewController : UIViewController {
    
    private let provider = MoyaProvider<CheckOutDataSource>()
    @IBOutlet weak var topView:  UIView!
    @IBOutlet weak var trackOrderBtn : UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var prescriptionImage : UIImageView!
    @IBOutlet weak var insuranceImage : UIImageView!
    @IBOutlet weak var paymentMethodType: UILabel!
    @IBOutlet weak var itemsCost : UILabel!
    @IBOutlet weak var deliveryCost : UILabel!
    @IBOutlet weak var VAT : UILabel!
    @IBOutlet weak var totalPrice : UILabel!
    @IBOutlet weak var collectionViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var cancelOrderBtn : UIButton!
    @IBOutlet weak var reOrderBtn : UIButton!
    @IBOutlet weak var prescriptionStackView : UIStackView!
    @IBOutlet weak var insuranceStackView : UIStackView!
    @IBOutlet weak var documentLabel : UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartViewHeightConstraint : NSLayoutConstraint!
    
    var ordersList = [Item]()
    var order = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackOrderBtn.setUnderLineText(text: Strings.shared.trackOrder)
        getOrderDetailsData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              
              if Utils.loadUser()?.accessToken ?? "" != "" {
                 Intercom.setLauncherVisible(true)
              }
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
    
    
    @IBAction func trackOrderPressed(_ sender: UIButton){
        let vc = TrackOrderViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
        vc.order = order
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func getOrderDetailsData() {
        KVNProgress.show()
        provider.request(.orderDetails(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let ordersDetailsResponse = try response.map(BaseResponse<OrderDetailsResponse>.self)
                    
                    self.setData(ordersDetailsResponse : ordersDetailsResponse.data ?? OrderDetailsResponse())
                    
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
    
    
    func setData(ordersDetailsResponse : OrderDetailsResponse){
        
        
        let orderStatus =  ordersDetailsResponse.orderStatusId ?? -1
        
        if orderStatus == 1 {
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            reOrderBtn.isHidden = true
            reOrderBtn.isEnabled = false
            cancelOrderBtn.isHidden = false
            cancelOrderBtn.isEnabled = true
        }else if (orderStatus == 2) ||  (orderStatus == 3) ||  (orderStatus == 6) {
            cartViewHeightConstraint.constant = 88
            cartView.isHidden = false
            reOrderBtn.isHidden = false
            reOrderBtn.isEnabled = true
            cancelOrderBtn.isHidden = true
            cancelOrderBtn.isEnabled = false
        }else{
            cartViewHeightConstraint.constant = 0
            cartView.isHidden = true
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
        
        itemsCost.text = Strings.shared.RSD + " \(ordersDetailsResponse.itemsCost ?? 0.0)"
        deliveryCost.text = Strings.shared.RSD +  " \(ordersDetailsResponse.deliveryCost ?? 0.0)"
        totalPrice.text = Strings.shared.RSD + " \(ordersDetailsResponse.finalTotalCost ?? 0.0)"
        VAT.text = "\(ordersDetailsResponse.vatCost ?? 0.0) %"
        
        if (ordersDetailsResponse.insuranceNumberImageLink ?? "") == "" &&
            (ordersDetailsResponse.prescriptionImageLink ?? "") == "" {
            documentLabel.isHidden = true
        }
        
        if (ordersDetailsResponse.insuranceNumberImageLink ?? "") != "" {
            insuranceStackView.isHidden = false
            insuranceImage.sd_setImage(with: URL.init(string: ordersDetailsResponse.insuranceNumberImageLink ?? ""))
        }
        
        
        
        
        if (ordersDetailsResponse.prescriptionImageLink ?? "") != "" {
            prescriptionStackView.isHidden = false
            prescriptionImage.sd_setImage(with: URL.init(string: ordersDetailsResponse.prescriptionImageLink ?? ""))
        }
        
        
        
        prescriptionImage.sd_setImage(with: URL.init(string: ordersDetailsResponse.prescriptionImageLink ?? ""))
        
        self.ordersList = ordersDetailsResponse.products ?? []
        self.addressLabel.text = ordersDetailsResponse.deliveryAddress ?? ""
        
        let rows : Float  = Float(ordersList.count / 3)
        var totalNumberOfRows : CGFloat = 0.0
        if rows == 0 {
            totalNumberOfRows = 1.0
        }else{
            totalNumberOfRows = CGFloat(ceil(Float(rows)))
        }
        
        let collectionWidth = (self.collectionView.bounds.width / 3.0)
        self.collectionViewHeightConstraint.constant = CGFloat(totalNumberOfRows) * (collectionWidth + 50)
        self.view.layoutIfNeeded()
        self.collectionView.reloadData()
        
        
    }
    
    
    
    @IBAction func reOrderPressed(_ sender : UIButton){
        
        
        Utils.updateUserCart(list: ordersList) {
            let vc = MainCartViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
            vc.items = self.ordersList
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
    @IBAction func cancelOrderPressed(_ sender : UIButton){
        KVNProgress.show()
        provider.request(.cancelOrder(order.id ?? -1)) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.dismiss(animated: true) {
                     NotificationCenter.default.post(name: Notification.Name(Constants.RELOAD_ORDERS_LIST), object: nil)
                }
                break
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

extension OrderDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailsCell.identifier, for: indexPath) as! ProductDetailsCell
        
        
        cell.setData(item: ordersList[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 3.0)
        let height = width + 50.0
        
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
