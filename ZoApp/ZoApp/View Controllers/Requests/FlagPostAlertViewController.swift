//
//  FlagPostAlertViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class FlagPostAlertViewController: UIViewController {

    // MARK: - Outlets
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
