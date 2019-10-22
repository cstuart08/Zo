//
//  NoResponseBodyTextViewController.swift
//  ZoApp
//
//  Created by Blake kvarfordt on 10/22/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class NoResponseBodyTextViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.zoBlack.withAlphaComponent(0.85)
        popupView.backgroundColor = .boldGreen
        textLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        textLabel.textColor = .zoWhite
        textLabel.text = "Missing text. Add a message to your response."
        okayButton.setTitle("OKAY!", for: .normal)
        okayButton.backgroundColor = .boldGreen
        okayButton.setTitleColor(.zoWhite, for: .normal)
        okayButton.addAccentBorder(width: 2.0, color: .zoWhite)
        okayButton.addCornerRadius(13.0)
    
    }
    
    @IBAction func okayButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
