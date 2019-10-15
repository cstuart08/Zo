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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
