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

class ItemsListViewController: UIViewController {
    
    var presenter : ViewToPresenterItemsListProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
}
extension ItemsListViewController : PresenterToViewItemsListProtocol {
    

}
