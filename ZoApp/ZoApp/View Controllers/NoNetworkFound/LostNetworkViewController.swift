//
//  LostNetworkViewController.swift
//  ZoApp
//
//  Created by Apps on 10/21/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class LostNetworkViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lostNetworkLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.zoBlack.withAlphaComponent(0.85)
        backgroundView.backgroundColor = .boldGreen
        lostNetworkLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        lostNetworkLabel.textColor = .zoWhite
        lostNetworkLabel.text = " Uh-oh! It looks like you are not connected to the internet! \n \n Please connect to the internet and retry!"
        okayButton.setTitle("OKAY!", for: .normal)
        okayButton.backgroundColor = .boldGreen
        okayButton.setTitleColor(.zoWhite, for: .normal)
        okayButton.addAccentBorder(width: 2.0, color: .zoWhite)
        okayButton.addCornerRadius(13.0)
    }
    
    // MARK: - Actions
    @IBAction func okayButtonTapped(_ sender: Any) {
        let notification = Notification(name: Notification.Name(rawValue: "lostNetworkDismissed"))
        NotificationCenter.default.post(notification)
        self.dismiss(animated: true)
    }
}
