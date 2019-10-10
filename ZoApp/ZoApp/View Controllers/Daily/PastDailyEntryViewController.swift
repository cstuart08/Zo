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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    // MARK - Properties
    var dailyJournal: DailyJournal?
    var editToggle = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pastDailyEntryTextView.isSelectable = false
        pastDailyEntryTextView.isEditable = false
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
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        if editToggle == false {
            editButton.setTitle("Save", for: .normal)
            pastDailyEntryTextView.isSelectable = true
            pastDailyEntryTextView.isEditable = true
            editToggle = true
        } else {
            editButton.setTitle("Edit", for: .normal)
            pastDailyEntryTextView.isSelectable = false
            pastDailyEntryTextView.isEditable = false
            editToggle = false
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
    }
}
