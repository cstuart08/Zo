//
//  PastDailyEntryViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class PastDailyEntryViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var pastDailyEntryImageView: UIImageView!
    @IBOutlet weak var pastDailyEntryTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    
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
        stylizeSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        tap.cancelsTouchesInView = true
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Methods
    @objc func tapDismiss() {
        if self.view == pastDailyEntryImageView {
            return
        } else {
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: alertView) {
            return false
        } else {
            return true
        }
    }
    
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
    
    func saveUpdatedJournal() {
        guard let dailyJournalEntry = dailyJournal else { return }
        guard let updatedText = pastDailyEntryTextView.text else { return }
        DailyController.shared.saveUpdatedJournal(dailyJournal: dailyJournalEntry, entry: updatedText) { (success) in
            if success {
                print("Success updating entry")
            } else {
                print("Failed to update entry.")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToDeleteVC" {
            guard let destinationVC = segue.destination as? DeletePastDailyEntryViewController else { return }
            guard let dailyJournalToDelete = self.dailyJournal else { return }
            destinationVC.dailyJournalToDelete = dailyJournalToDelete
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
            saveUpdatedJournal()
        }
    }
    
    // MARK: - UI Adjustments
    func stylizeSubviews() {
        alertView.backgroundColor = .zoWhite
        alertView.addCornerRadius()
        pastDailyEntryTextView.addCornerRadius()
        pastDailyEntryTextView.addAccentBorder(width: 5, color: .boldGreen)
        pastDailyEntryTextView.addPadding()
        pastDailyEntryTextView.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.rawValue)
        pastDailyEntryTextView.textColor = .zoBlack
        deleteButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        deleteButton.setTitleColor(.zoBlack, for: .normal)
        editButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        editButton.setTitleColor(.zoBlack, for: .normal)
        dateLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.rawValue)
        dateLabel.text = dateLabel.text?.uppercased()
    }
}
