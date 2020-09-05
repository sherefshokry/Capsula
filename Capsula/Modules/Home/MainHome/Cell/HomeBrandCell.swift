//
//  HomeBrandCell.swift
//  Capsula
//
//  Created by SherifShokry on 2/2/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class HomeBrandCell : UITableViewCell {
    
    @IBOutlet weak var seeAllBtn : UIButton!
        @IBOutlet weak var serviceNameLbl : UILabel!
        @IBOutlet weak var collectionView : UICollectionView!
        var fetchedBrands  = [Brand]()
        var seeAllPressed : (() -> ())?
        var brandPressed : ((Brand) -> ())?
        override func awakeFromNib() {
            super.awakeFromNib()
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: BrandCell.identifier, bundle: nil), forCellWithReuseIdentifier: BrandCell.identifier)
            seeAllBtn.setUnderLineText(text: Strings.shared.seeAll)
        }
        
    
    func setBrandData(brands : [Brand]){
        self.fetchedBrands = brands
        self.collectionView.reloadData()
        
    }
    
    @IBAction func seeAll(_ sender : UIButton){
        if seeAllPressed != nil {
            self.seeAllPressed?()
        }
    }

 }

  extension HomeBrandCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
       
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return fetchedBrands.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.identifier, for: indexPath) as! BrandCell
            cell.setData(brand: fetchedBrands[indexPath.row])
            return cell
        }
      
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize.init(width: 141, height: 141)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if brandPressed != nil {
             self.brandPressed?(fetchedBrands[indexPath.item] ?? Brand())
            }
        }

}
