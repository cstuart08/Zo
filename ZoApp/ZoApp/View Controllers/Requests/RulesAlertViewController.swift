//
//  RulesAlertViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class RulesAlertViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var rulesDetailsLabel: UILabel!
    @IBOutlet weak var rulesWarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        tap.cancelsTouchesInView = true
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapDismiss() {
        if self.view == rulesView {
            return
        } else {
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: rulesView) {
            return false
        } else {
            return true
        }
    }
    
    func setupUI() {
        rulesView.backgroundColor = .boldGreen
        rulesLabel.font = UIFont(name: FontAttributes.h1.fontFamily, size: FontAttributes.h1.fontSize)
        rulesLabel.textColor = .zoWhite
        rulesDetailsLabel.font = UIFont(name: FontAttributes.h3.fontFamily, size: FontAttributes.h3.fontSize)
        rulesDetailsLabel.textColor = .zoWhite
        rulesWarningLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        rulesWarningLabel.textColor = .zoWhite
        rulesView.addCornerRadius(16.0)
    }
}
