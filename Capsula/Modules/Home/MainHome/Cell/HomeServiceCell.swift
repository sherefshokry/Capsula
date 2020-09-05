//
//  HomeServiceCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class HomeServiceCell : UITableViewCell {
    
    @IBOutlet weak var seeAllBtn : UIButton!
    @IBOutlet weak var serviceNameLbl : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    
    var fetchedStores = [Store]()
    var fetchedCategories = [Category]()
    var seeAllPressed : ((Bool) -> ())?
    var categoryPressed : ((Category) -> ())?
    var storePressed : ((Int) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        seeAllBtn.setUnderLineText(text: Strings.shared.seeAll)
    }
    
    func setStoreData(stores : [Store]){
        fetchedStores = stores
        serviceNameLbl.text  = Strings.shared.stores
        collectionView.reloadData()
    }
    
    func setCategoryData(categories : [Category]){
        fetchedCategories = categories
        serviceNameLbl.text  = Strings.shared.categories
        collectionView.reloadData()
    }
    
    @IBAction func sellAllPressed(_ sender : UIButton){
        
        
        if seeAllPressed != nil {
            if fetchedStores.count > 0 {
                //true is store
                self.seeAllPressed?(true)
            }else if fetchedCategories.count > 0 {
                //false is category
                self.seeAllPressed?(false)
            }
            
        }
        
        
    }
    
    
}
extension HomeServiceCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fetchedStores.count > 0 {
            return fetchedStores.count
        }else if fetchedCategories.count > 0 {
            return fetchedCategories.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        if fetchedStores.count > 0 {
            cell.setStoreData(store: fetchedStores[indexPath.row])
            return cell
        }else if fetchedCategories.count > 0 {
            cell.setCategoryData(category: fetchedCategories[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 141, height: 171)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if fetchedStores.count > 0 {
            if storePressed != nil {
                self.storePressed?(fetchedStores[indexPath.item].storeId ?? -1)}
        }else if fetchedCategories.count > 0 {
            self.categoryPressed?(fetchedCategories[indexPath.item])
        }
    }
    
    
}
