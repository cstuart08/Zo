//
//  ZoButton.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/10/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ZoButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func updateFont(to fontName: String) {
        guard let size = titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: fontName, size: size)
    }
    
    func setupUI() {
        backgroundColor = .boldGreen
        updateFont(to: FontNames.latoRegular)
        setTitleColor(.zoWhite, for: .normal)
        addCornerRadius()
        addAccentBorder(width: 3, color: .zoWhite)
    }
}
