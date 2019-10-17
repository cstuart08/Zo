//
//  ZoLabel.swift
//  ZoApp
//
//  Created by Apps on 10/14/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ZoLabel: UILabel {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        super.drawText(in: rect.inset(by: insets))
    }
}
