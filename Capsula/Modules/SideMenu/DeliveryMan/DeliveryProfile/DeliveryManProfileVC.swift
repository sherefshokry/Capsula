//
//  DeliveryManProfileVC.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import FSPagerView

class DeliveryManProfileVC : UIViewController {
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var pageController: FSPageControl!
    @IBOutlet weak var pager: FSPagerView!{
        didSet {
            self.pager.register(UINib(nibName: "PersonalDetailsCell", bundle: nil), forCellWithReuseIdentifier: "PersonalDetailsCell")
            self.pager.register(UINib(nibName: "CarDetailsCell", bundle: nil), forCellWithReuseIdentifier: "CarDetailsCell")
            self.pager.register(UINib(nibName: "RequiredDocumentCell", bundle: nil), forCellWithReuseIdentifier: "RequiredDocumentCell")
            
            
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
              NotificationCenter.default.addObserver(self, selector: #selector(self.refreshDeliveryData(_:)), name: NSNotification.Name(rawValue: Constants.REFRESH_DELIVERY_DATA), object: nil)
        
        setUserData()
        
     
    }
    
    @objc func refreshDeliveryData(_ notification: NSNotification){
        setUserData()
        self.pager.reloadData()
    }
    

    func setUserData(){
        
        let user =  Utils.loadDeliveryUser()?.user ?? DeliveryUser()
             userImage.sd_setImage(with: URL.init(string: user.personalPicture ?? ""), placeholderImage: nil)
             userName.text = user.fullName ?? ""
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 70
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setPager()
    }
    
    
    func setPager(){
        self.pager.dataSource = self
        self.pager.delegate = self
        self.pager.itemSize = CGSize.init(width: self.view.frame.width , height: self.view.frame.height - (260 + UIApplication.shared.statusBarFrame.height))
        self.pageController.setFillColor(UIColor.init(red: 14/255, green: 81/255, blue: 138/255, alpha: 0.3), for: .normal)
        self.pageController.setFillColor(UIColor.init(red: 14/255, green: 81/255, blue: 138/255, alpha: 1), for: .selected)
        self.pager.reloadData()
        self.pageController.numberOfPages = 3
        self.pageController.reloadInputViews()
    }
    
    
    @IBAction func editDeliveryManProfile(_ sender : UIButton){
        let vc = EditDeliveryProfileStep1VC.instantiateFromStoryBoard(appStoryBoard: .SideMenu)
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
extension DeliveryManProfileVC : FSPagerViewDataSource
{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        
        return 3
        
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        if index == 0 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PersonalDetailsCell", at: index) as! PersonalDetailsCell
            cell.setData()
            return cell
        }else if index == 1 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CarDetailsCell", at: index) as! CarDetailsCell
            cell.setData()
            return cell
        }else if index == 2 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "RequiredDocumentCell", at: index) as! RequiredDocumentCell
            cell.setData()
            return cell
        }
        
        return FSPagerViewCell()
    }
}

extension DeliveryManProfileVC : FSPagerViewDelegate
{
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int)
    {
        self.pageController.currentPage = targetIndex
        
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        self.pageController.currentPage = index
    }
}

