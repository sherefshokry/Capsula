//
//  FAQViewController.swift
//  Capsula
//
//  Created by SherifShokry on 8/21/20.
//  Copyright © 2020 SherifShokry. All rights reserved.
//

import UIKit
import Moya
import KVNProgress


class FAQViewController : UIViewController {
    
    var faqList = [FAQ]()
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var tableView : UITableView!
    private let provider = MoyaProvider<HomeDataSource>()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        getFAQSData()
       }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           topView.clipsToBounds = true
           topView.layer.cornerRadius = 70
           topView.layer.maskedCorners = [.layerMinXMaxYCorner]
       }
    
    
    
    func getFAQSData() {
        KVNProgress.show()
        provider.request(.getFAQS) { [weak self] result in
            KVNProgress.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let faqsData = try response.map(BaseResponse<FAQResponse>.self)
                    self.faqList = faqsData.data?.faqsList ?? []
                    self.tableView.reloadData()
                    
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
