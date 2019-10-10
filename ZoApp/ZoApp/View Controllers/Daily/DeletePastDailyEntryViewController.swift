//
//  DeletePastDailyEntryViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
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
