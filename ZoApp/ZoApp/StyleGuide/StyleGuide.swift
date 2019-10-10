//
//  StyleGuide.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/10/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit


struct FontNames {
    static let latoBold = "Lato-Bold"
    static let latoBoldItaltic = "Lato-BoldItalic"
    static let latoRegular = "Lato-Regular"
    static let latoRegularItalic = "Lato-RegularItalic"
    static let fingerPaint = "FingerPaint-Regular"
}

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 1, color: UIColor = .boldGreen) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

extension UIColor {
    static let black = UIColor(named: "black")!
    static let darkBlue = UIColor(named: "darkBlue")!
    static let boldGreen = UIColor(named: "boldGreen")!
    static let forestGreen = UIColor(named: "forestGreen")!
    static let blueGrey = UIColor(named: "blueGrey")!
    static let sageGreen = UIColor(named: "sageGreen")!
    static let ivory = UIColor(named: "ivory")!
    static let lightPink = UIColor(named: "lightPink")!
    static let zoWhite = UIColor(named: "white")!
}
