//
//  DailyViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var todayTitleLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var pastEntriesTableView: UITableView!
    @IBOutlet weak var dailyEntryTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var pastDailyEntriesLabel: UILabel!
    
    // MARK: - Properties
    var photo: UnsplashPhoto?
    var currentDate = DateHelper.shared.mediumDateSTRfromDouble(dateDouble: Double(Date().timeIntervalSince1970))
    var createdEntryToday = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyEntryTextView.delegate = self
        dailyEntryTextView.text = "Enter your thoughts here..."
        dailyEntryTextView.textColor = .blueGrey
        pastEntriesTableView.delegate = self
        pastEntriesTableView.dataSource = self
        dailyImageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
        category(.inspirationalQuote)
        let notification = Notification.Name(rawValue: "reloadTableView")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViews), name: notification, object: nil)
        didReachDailyJournalLimit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMyJournals()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stylizeSubviews()
        didReachDailyJournalLimit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - UI Adjustments
    func stylizeSubviews() {
        dailyEntryTextView.addCornerRadius(13)
        dailyEntryTextView.addAccentBorder(width: 2, color: .boldGreen)
        dailyEntryTextView.addPadding()
        dailyEntryTextView.textColor = .blueGrey
        view.backgroundColor = .ivory
        todayTitleLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        todayTitleLabel.textColor = .blueGrey
        todayView.addCornerRadius()
        todayView.addAccentBorder(width: 2, color: .boldGreen)
        pastEntriesTableView.backgroundColor = .clear
        pastDailyEntriesLabel.textColor = .blueGrey
        pastDailyEntriesLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        dailyImageView.addCornerRadius()
    }
    
    // MARK: - Methods    
    func displayKarmaPointsAlert() {
        guard let viewController = UIStoryboard(name: "PointsAndRank", bundle: nil).instantiateViewController(withIdentifier: "pointsAndRankStoryBoard") as? PointsAndRankVC else { return }
        self.present(viewController, animated: true, completion: nil)
    }
    
    func didReachDailyJournalLimit() {
        guard let firstEntry = DailyController.shared.myDailyJournals.first else { return }
        let firstEntryDate = DateHelper.shared.mediumDateSTRfromDouble(dateDouble: firstEntry.timestamp)
        if firstEntryDate == currentDate {
            createdEntryToday = true
            saveButton.isHidden = true
            refreshButton.isHidden = true
            dailyEntryTextView.isEditable = false
            dailyEntryTextView.text = "You reached your limit of one daily journal for today."
        } else {
            createdEntryToday = false
            saveButton.isHidden = false
            refreshButton.isHidden = false
            dailyEntryTextView.isEditable = true
            dailyEntryTextView.text = "Enter your thoughts here..."
        }
    }
    
    @objc func tapResign() {
        dailyEntryTextView.resignFirstResponder()
    }
    
    @objc func reloadTableViews() {
        self.pastEntriesTableView.reloadData()
        didReachDailyJournalLimit()
    }
    
    func category(_ unsplashRoute: UnsplashRoute) {
        
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                guard let image = photos.first else { return }
                self.photo = image
                self.fetchImage(photo: image)
            }
        }
    }
    
    func fetchImage(photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.dailyImageView.image = image
            }
        }
    }
    
    func fetchMyJournals() {
        DailyController.shared.fetchDailyJournals { (success) in
            DispatchQueue.main.async {
                self.pastEntriesTableView.reloadData()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if dailyEntryTextView.textColor == UIColor.blueGrey {
            dailyEntryTextView.text = nil
            dailyEntryTextView.textColor = UIColor.zoBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if dailyEntryTextView.text.isEmpty {
            dailyEntryTextView.text = "Enter your thoughts here..."
            dailyEntryTextView.textColor = UIColor.blueGrey
        }
    }
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        category(.inspirationalQuote)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if createdEntryToday == false {
            
            guard let entry = dailyEntryTextView.text,
                let userReferencce = UserController.shared.currentUser?.appleUserReference,
                let urlString = self.photo?.urls.regular else { return }
            DailyController.shared.createDailyJournal(imageURL: urlString, entry: entry, userReference: userReferencce) { (success) in
                DispatchQueue.main.async {
                    print("Success saving a daily journal.")
                    self.pastEntriesTableView.reloadData()
                    self.didReachDailyJournalLimit()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pastDailyCellToDetailVC" {
            if let index = pastEntriesTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? PastDailyEntryViewController else { return }
                let dailyJournalToSend = DailyController.shared.myDailyJournals[index.row]
                destinationVC.dailyJournal = dailyJournalToSend
            }
        }
    }
}

// MARK: - Extensions
extension DailyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DailyController.shared.myDailyJournals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pastDailyJournalEntry", for: indexPath) as? PastDailyEntriesTableViewCell else { return UITableViewCell()}
        let entry = DailyController.shared.myDailyJournals[indexPath.row]
        
        cell.titleLabel.text = DateHelper.shared.mediumDateSTRfromDouble(dateDouble: entry.timestamp).uppercased()
        return cell
    }
    
    
}
