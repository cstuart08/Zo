//
//  TextViewExtension.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/11/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit


extension UITextView {
    
    func setupDailyTextViewUI() {
        backgroundColor = .zoWhite
        textColor = .zoBlack
        setupBorder()
        addPadding()
        updateFont(to: FontNames.latoRegular)
    }
    
    func updateFont(to fontName: String) {
        guard let size = font?.pointSize else { return }
        font = UIFont(name: fontName, size: size)
    }
    
    func setupBorder() {
        layer.borderColor = UIColor.boldGreen.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 13
    }
    
    func addPadding() {
        textContainerInset.bottom = 15
        textContainerInset.top = 15
        textContainerInset.left = 15
        textContainerInset.right = 15
    }
}
