//
//  PastDailyEntryViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class PastDailyEntryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pastDailyEntryImageView: UIImageView!
    @IBOutlet weak var pastDailyEntryTextView: UITextView!
    
    // MARK - Properties
    var dailyJournal: DailyJournal?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPastImage()
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        pastDailyEntryTextView.resignFirstResponder()
    }
    
    func setupViews() {
        guard let dailyJournalEntry = dailyJournal else { return }
        pastDailyEntryTextView.text = dailyJournalEntry.entry
    }
    
    func fetchPastImage() {
        guard let dailyJournalEntry = dailyJournal else { return }
        UnsplashService.shared.fetchImageFromURLString(urlString: dailyJournalEntry.imageURL) { (image) in
            DispatchQueue.main.async {
                self.pastDailyEntryImageView.image = image
            }
        }
    }
    
}
