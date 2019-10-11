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
    
    // MARK: - Properties
    var dailyJournalToDelete: DailyJournal?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func yesButtonTapped(_ sender: Any) {
        guard let dailyJournal = dailyJournalToDelete else { return }
        DailyController.shared.deleteDailyJournal(dailyJournal: dailyJournal) { (success) in
            if success {
                DispatchQueue.main.async {
                    print("Successfully deleted daily journal.")
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true)
                }
            } else {
                print("Unable to delete daily journal.")
            }
        }
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
