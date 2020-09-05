//
//  AddressListViewController.swift
//  Capsula
//
//  Created by SherifShokry on 4/20/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import KVNProgress
import Moya
import ContentSheet
import Intercom


class AddressListViewController : UIViewController{
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var tableViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var addAddressBtn : UIButton!
    @IBOutlet weak var scrollView : UIScrollView! 
    var refreshCheckoutAddress : (() -> ())?
    var newAddress = Address()
    var addressList = [Address]()
    var selectedIndex = -1
    var currentUser = User()
    private let provider = MoyaProvider<UserDataSource>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAddressBtn.setUnderLineText(text: Strings.shared.addAddress)
        currentUser = Utils.loadUser()?.user ?? User()
        newAddress = currentUser.defaultAddress ?? Address()
        addressList = currentUser.addressList ?? []
        let index = addressList.firstIndex(of: newAddress) ?? -1
        
        addressList[index].isSelected = true
     
        tableView.reloadData()
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
    
    
    @IBAction func addNewAddress(_ sender: UIButton){
    
         let vc = AddAddressViewController.instantiateFromStoryBoard(appStoryBoard: .PreLogin)
        vc.openHomeScreen = true
        self.dismiss(animated: true) {
            
            UIApplication.shared.windows[0].visibleViewController?.present(vc, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
    @IBAction func applyPressed(_ sender : UIButton){
        
        
        
               if (addressList[selectedIndex].id ?? -1) ==  (currentUser.defaultAddress?.id ?? -1){
                   self.dismiss(animated: true, completion: nil)
               }else{
                    newAddress = addressList[selectedIndex]
                    updateDefaultAddress()
               }
        
        
    }
    
    
    
    func updateDefaultAddress(){
        
                 KVNProgress.show()
        provider.request(.updateDefaultAddress(newAddress.id ?? -1)) { [weak self] result in
                                 guard let self = self else { return }
                                 switch result {
                                 case .success:
                                    KVNProgress.dismiss()
                              
              var updatedUser = Utils.loadUser() ?? UserResponse()
                                        updatedUser.user?.defaultAddress = self.newAddress
              Utils.saveUser(user: updatedUser)
              self.tableView.reloadData()
                                    if self.refreshCheckoutAddress != nil{
                                        self.refreshCheckoutAddress?()
                                    }
                                
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.dismiss(animated: true, completion: nil)
                                            
              }

                                   
                                 case .failure(let error):
                                     do{
                                         if let body = try error.response?.mapJSON(){
                                             let errorData = (body as! [String:Any])
                                            KVNProgress.dismiss()
                                          self.showMessage((errorData["errors"] as? String) ?? "")
                                         }
                                     }catch{
                                        KVNProgress.dismiss()
                                      self.showMessage(error.localizedDescription)
                                     }
                                 }
                             }}
}

extension AddressListViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier, for: indexPath) as! AddressCell
        
        if (addressList[indexPath.row].isSelected){
            selectedIndex = indexPath.row
        }
        cell.setData(address: addressList[indexPath.row])
        let numberOfCells = addressList.count 
        tableViewHeightConstraint.constant = CGFloat(66 * numberOfCells)
        self.view.layoutIfNeeded()
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var index = 0
        for _ in addressList {
            addressList[index].isSelected = false
            index = index + 1
        }
        self.addressList[indexPath.row].isSelected = true
        self.tableView.reloadData()
        
    }

      override func scrollViewToObserve(containedIn contentSheet: ContentSheet) -> UIScrollView? {
        return scrollView
      }
    
    override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
          return 900
      }
      
      override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
          return 350
      }
}


