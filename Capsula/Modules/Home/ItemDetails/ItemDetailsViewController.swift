//
//  ItemDetailsViewController.swift
//  Capsula
//
//  Created SherifShokry on 3/28/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import KVNProgress
import Intercom

class ItemDetailsViewController: UIViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var priceBeforeDiscountLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var storeName : UILabel!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var stackView : UIStackView!
    var presenter : ViewToPresenterItemDetailsProtocol?

    private var state: State = .loading {
         didSet {
             switch state {
             case .ready:
                 KVNProgress.dismiss()
             case .loading:
                 KVNProgress.show(withStatus: "", on: self.view)
             case .error(let error):
                 KVNProgress.dismiss()
                 self.showMessage(error)
             }
         }
     }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           if Utils.loadUser()?.accessToken ?? "" != "" {
              Intercom.setLauncherVisible(true)
           }
           
       }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
         topView.clipsToBounds = true
         topView.layer.cornerRadius = 70
         topView.layer.maskedCorners = [.layerMaxXMinYCorner]
     }
    
    @IBAction func addToCart(_ sender : UIButton)
    {
        self.presenter?.addItemToCart()
    }
    
}
extension ItemDetailsViewController : PresenterToViewItemDetailsProtocol {
    func setItemDetails(item: Item) {
        itemImage.sd_setImage(with: URL.init(string: item.imagePath ?? ""))
        titleLabel.text = item.productName ?? ""
        priceLabel.text = "\(item.price ?? 0.0) \(Strings.shared.RSD)"
        if item.offerType == -1 {
            descriptionLabel.text = item.productDesc
        }else{
            descriptionLabel.text = item.offerDesc
        }
        
        if item.storeName ?? "" != ""{
            storeName.text = Strings.shared.availableAt + (item.storeName ?? "")
        }

        if item.priceInOffer ?? 0.0 == 0.0{
            priceBeforeDiscountLabel.isHidden = true
        }else{
            priceBeforeDiscountLabel.isHidden = false
            priceBeforeDiscountLabel.text = "\(Strings.shared.was) \(item.priceInOffer ?? 0.0)" + Strings.shared.rsd
        }
        
        
        
    }
    
    func showPopup(message : String){
        self.showMessage(message)
    }

    
    
      func changeState(state: State) {
          self.state = state
      }
}
