//
//  ZoButton.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/11/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ZoButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .ivory
        updateFont(to: FontNames.latoRegular)
        setTitleColor(.boldGreen, for: .normal)
        addCornerRadius()
        addAccentBorder(width: 3, color: .boldGreen)
        
    }
    
    func updateFont(to fontName: String) {
        guard let size = titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: fontName, size: size)
    }
}
