//
//  ZoButton.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class OnBoardingButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .boldGreen
        updateFont(to: FontNames.latoRegular)
        setTitleColor(.zoWhite, for: .normal)
        addCornerRadius()
        addAccentBorder(width: 3, color: .zoWhite)
    }
    
    func updateFont(to fontName: String) {
        guard let size = titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: fontName, size: size)
    }
}
