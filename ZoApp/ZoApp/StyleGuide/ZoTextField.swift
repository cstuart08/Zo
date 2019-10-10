//
//  ZoTextField.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/10/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ZoTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFont(to: FontNames.latoRegular)
        setupUI()
    }
    
    func setupUI() {
        updatePlaceholderColor()
        textColor = .zoWhite
        backgroundColor = .boldGreen
        tintColor = .zoWhite
        addAccentBorder()
        addCornerRadius()
        layer.masksToBounds = true
    }
    
    func updatePlaceholderColor() {
        let placeholderText = placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [.foregroundColor : UIColor.zoWhite,
                                                                     .font : UIFont(name: FontNames.latoRegular, size: 16)!])
    }
    
    func updateFont(to fontName: String) {
        guard let size = font?.pointSize else { return }
        font = UIFont(name: fontName, size: size)
    }
}
