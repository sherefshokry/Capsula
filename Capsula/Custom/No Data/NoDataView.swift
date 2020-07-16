//
//  NoDataView.swift
//  Masters
//
//  Created by Nora on 2/27/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    @IBOutlet weak var noDataImageView: UIImageView!
    @IBOutlet weak var msgLbl : UILabel!

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
}
