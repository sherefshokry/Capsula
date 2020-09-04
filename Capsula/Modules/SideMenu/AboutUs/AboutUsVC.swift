//
//  AboutUsVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya

class AboutUsVC : UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var aboutImage : UIImageView!
    @IBOutlet weak var aboutDescription : UILabel!
     private let provider = MoyaProvider<HomeDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAboutData()
    }
    
    override func viewWillLayoutSubviews() {
             super.viewWillLayoutSubviews()
             topView.clipsToBounds = true
             topView.layer.cornerRadius = 70
             topView.layer.maskedCorners = [.layerMinXMaxYCorner]
         }
      
    
    func getAboutData() {
          KVNProgress.show()
          provider.request(.getTerms) { [weak self] result in
              KVNProgress.dismiss()
              guard let self = self else { return }
              switch result {
              case .success(let response):
                  do {
                      let termsData = try response.map(BaseResponse<String>.self)
                      self.aboutDescription.text = termsData.data ?? ""
                  }catch(let catchError) {
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
