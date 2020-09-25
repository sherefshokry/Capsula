//
//  ItemsListViewController.swift
//  Capsula
//
//  Created SherifShokry on 2/15/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import KVNProgress
import ContentSheet
import Intercom

class ItemsListViewController: UIViewController {
    
    var presenter : ViewToPresenterItemsListProtocol?
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var searchField  : UITextField!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var cartView : UIView!
    @IBOutlet weak var cartNumberItemsLabel : UILabel!
    
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready:
                KVNProgress.dismiss()
                collectionView.reloadData()
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
        setupCollectionViewLayout()
        self.presenter?.getItemsData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.recieveCartNotification(_:)), name: NSNotification.Name(rawValue: Constants.CART_UPDATE_NOTIFICATION), object: nil)
        updateCartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           if Utils.loadUser()?.accessToken ?? "" != "" {
              Intercom.setLauncherVisible(true)
              Intercom.registerUser(withEmail: Utils.loadUser()?.user?.email ?? "")
           }
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                          searchField.textAlignment = .right
                      }else{
                          searchField.textAlignment = .left
                      }
        
           
       }
   
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 70
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        
    }
    
    
    
    func setupCollectionViewLayout(){
        collectionView.register(UINib.init(nibName: ItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemCell.identifier)
    }
    
    
        @IBAction func searchItemPressed(_ sneder : UIButton){
            let vc = SearchItemRouter.createModule()
            self.present(vc, animated: true, completion: nil)
        }
        
    

    @IBAction func openCartScreen(_ sender : UIButton){
       let cartList  =  Utils.loadLocalCart() ?? []
        
        if cartList.count > 0 {
            let vc = MainCartRouter.createModule()
            self.present(vc, animated: true, completion: nil)
        }else{
            self.showMessage(Strings.shared.cartMsg)
        }
          
    }
    
  @objc func recieveCartNotification(_ notification: NSNotification){
        updateCartView()
    }
    
    
       func updateCartView(){
          let cartItems = Utils.loadLocalCart() ?? []
          if (cartItems.count > 0){
                cartView.isHidden = false
                cartNumberItemsLabel.text = "\(cartItems.count)"
          }else{
               cartView.isHidden = true
          }
         view.layoutIfNeeded()
      }
    
    
}
extension ItemsListViewController : PresenterToViewItemsListProtocol {
    
    func changeState(state: State) {
        self.state = state
    }
    
}
extension ItemsListViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        self.presenter?.configureItemCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = (self.collectionView.frame.width - 42) / 2
        return CGSize(width: collectionWidth, height: collectionWidth + 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelectItem(indexPath: indexPath)
    }
    
}
