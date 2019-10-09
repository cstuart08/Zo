//
//  DeletePastDailyEntryViewController.swift
//  JustBreateApp
//
//  Created by Apps on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class DeletePastDailyEntryViewController: UIViewController {
    
    // MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func yesButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
