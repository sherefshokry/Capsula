//
//  TermsAndConditionVC.swift
//  Capsula
//
//  Created by SherifShokry on 6/30/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import Intercom


class TermsAndConditionVC : UIViewController {
    
    @IBOutlet weak var termsTextLabel : UILabel!
    @IBOutlet weak var topView : UIView!
    private let provider = MoyaProvider<DeliveryManRegistrationDataSource>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTermsData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Intercom.setLauncherVisible(false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    func getTermsData() {
        KVNProgress.show()
        provider.request(.getTermsAndConditions) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let termsData = try response.map(BaseResponse<String>.self)
                    self.termsTextLabel.text = termsData.data ?? ""
                    
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
