//
//  WelcomeOnboardingViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class WelcomeOnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeSubviews()
    }
    

    // MARK: - UI Adjustments
    
    func stylizeSubviews() {
        view.backgroundColor = .boldGreen
        titleLabel.font = UIFont(name: FontAttributes.h1.fontFamily, size: FontAttributes.h1.fontSize)
        titleLabel.textColor = .zoWhite
        bodyTextLabel.font = UIFont(name: FontAttributes.h3.fontFamily, size: FontAttributes.h3.fontSize)
        bodyTextLabel.textColor = .zoWhite
    }

}
