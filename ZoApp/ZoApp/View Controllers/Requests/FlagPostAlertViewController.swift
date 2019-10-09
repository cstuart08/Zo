//
//  FlagPostAlertViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/8/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
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
