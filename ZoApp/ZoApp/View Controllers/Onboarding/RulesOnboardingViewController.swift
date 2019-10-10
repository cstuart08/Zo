//
//  RulesOnboardingViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class RulesOnboardingViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bulletPointsLabel: UILabel!
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeSubviews()
    }
    

    // MARK: - UI Adjustments
    
    func stylizeSubviews() {
        view.backgroundColor = .boldGreen
        titleLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        titleLabel.textColor = .zoWhite
        bulletPointsLabel.font = UIFont(name: FontAttributes.h4.fontFamily, size: FontAttributes.h4.rawValue)
        bulletPointsLabel.textColor = .zoWhite
        disclaimerLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.rawValue)
        disclaimerLabel.textColor = .zoWhite
    }

}
