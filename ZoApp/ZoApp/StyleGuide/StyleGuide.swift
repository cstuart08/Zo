//
//  StyleGuide.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
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
    func addCornerRadius(_ radius: CGFloat = 13) {
        layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 5, color: UIColor = .zoWhite) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

enum FontAttributes: CGFloat {
    case h1 = 36
    case h2 = 30
    case h3 = 24
    case h4 = 18
    case body = 16
    case caption = 14
    
    var fontFamily: String {
        switch self {
        case .h1, .h2:
            return FontNames.fingerPaint
        default:
            return FontNames.latoRegular
        }
    }
}



extension UIColor {
    static let zoBlack = UIColor(named: "zoBlack")!
    static let darkBlue = UIColor(named: "darkBlue")!
    static let boldGreen = UIColor(named: "boldGreen")!
    static let forestGreen = UIColor(named: "forestGreen")!
    static let blueGrey = UIColor(named: "blueGrey")!
    static let sageGreen = UIColor(named: "sageGreen")!
    static let ivory = UIColor(named: "ivory")!
    static let lightPink = UIColor(named: "lightPink")!
    static let zoWhite = UIColor(named: "zoWhite")!
}
