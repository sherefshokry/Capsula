//
//  DeliveryManWalletVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/22/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Moya
import KVNProgress

class DeliveryManWalletVC : UIViewController {
    
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var totalCompletedOrder : UILabel!
    @IBOutlet weak var totalDeliveryCostInCash : UILabel!
    @IBOutlet weak var totalOnlineDeliveryCost : UILabel!
    @IBOutlet weak var totalDeliveryCost : UILabel!
    @IBOutlet weak var discounts : UILabel!
    @IBOutlet weak var cashOrdersCost : UILabel!
    @IBOutlet weak var bounses : UILabel!
    @IBOutlet weak var compensation : UILabel!
    @IBOutlet weak var balance : UILabel!
    @IBOutlet weak var payments : UILabel!
    @IBOutlet weak var collection : UILabel!
    @IBOutlet weak var finalBalance : UILabel!
    private let provider = MoyaProvider<DeliveryManDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addBackground(color: .white)
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        getWalletData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setWalletData(item: WalletItem){
        
        
        
        
        totalCompletedOrder.text = "\(item.countOfCompletedOrders ?? 0)"
        totalDeliveryCostInCash.text = Strings.RSD +  " \(item.totalCreditCustomerOrderAmountCash?.rounded(toPlaces: 2) ?? 0)"
        totalOnlineDeliveryCost.text = Strings.RSD +  " \(item.totalDeliveryCostOnlineOrder?.rounded(toPlaces: 2) ?? 0.0)"
        totalDeliveryCost.text = Strings.RSD +  " \(item.totalDeliveryCost?.rounded(toPlaces: 2) ?? 0.0)"
        discounts.text = Strings.RSD +  " \(item.discount?.rounded(toPlaces: 2) ?? 0.0)"
        cashOrdersCost.text = Strings.RSD +  " \(item.totalDeliveryCostCashOrder?.rounded(toPlaces: 2) ?? 0.0)"
        bounses.text = Strings.RSD +  " \(item.bonuses?.rounded(toPlaces: 2) ?? 0.0)"
        compensation.text = Strings.RSD +  " \(item.compensations?.rounded(toPlaces: 2) ?? 0.0)"
        balance.text = Strings.RSD +  " \(item.balance?.rounded(toPlaces: 2) ?? 0.0)"
        payments.text = Strings.RSD +  " \(item.payments?.rounded(toPlaces: 2) ?? 0.0)"
        collection.text = Strings.RSD +  " \(item.collection?.rounded(toPlaces: 2) ?? 0.0)"
        finalBalance.text = Strings.RSD +  " \(item.endingBalance?.rounded(toPlaces: 2) ?? 0.0)"
        
    }
    
    
    
    func getWalletData() {
        KVNProgress.show()
        provider.request(.getWallet) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let walletResponse = try response.map(BaseResponse<WalletItem>.self)
                    
                    self.setWalletData(item:walletResponse.data ?? WalletItem())
                    
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

