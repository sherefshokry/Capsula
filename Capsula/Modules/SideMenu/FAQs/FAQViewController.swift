//
//  FAQViewController.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit

class FAQViewController : UIViewController {
    
    var faqList = [FAQ]()
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var tableView : UITableView!

    
    override func viewDidLoad() {
           super.viewDidLoad()
        
    var faqItem = FAQ()
        faqItem.name = "Faq Title"
        faqItem.description = "Faq Description"
        faqItem.isExpanded = false
        faqList.append(faqItem)
        tableView.reloadData()
        
       }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           topView.clipsToBounds = true
           topView.layer.cornerRadius = 70
           topView.layer.maskedCorners = [.layerMinXMaxYCorner]
       }
    
    
    
}



extension FAQViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAQCell.identifier, for: indexPath) as! FAQCell
        cell.funcToLoad = { sender in
            let indexPath = tableView.indexPath(for: sender)
            self.updateView(index : indexPath?.row ?? 0)
        }
        cell.setData(content: faqList[indexPath.row])

        
        return cell
    }
    
    func updateView(index : Int) {
      var isExpanded = faqList[index].isExpanded
        isExpanded = !isExpanded
        faqList[index].isExpanded = isExpanded 
        reloadWithoutAnimation(index: index)
    }

    
    func reloadWithoutAnimation(index : Int) {
     let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
