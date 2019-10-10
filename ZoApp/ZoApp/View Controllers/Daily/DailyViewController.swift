//
//  DailyViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var pastEntriesTableView: UITableView!
    @IBOutlet weak var dailyEntryTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
        /// MOCK DATA
        let pastDailyEntries = ["OCT 3, 2019", "OCT 2, 2019", "OCT 1, 2019", "SEP 27, 2019", "SEP 26, 2019", "SEP 24, 2019", "SEP 22, 2019", "SEP 21, 2019"]
    var photo: UnsplashPhoto?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pastEntriesTableView.delegate = self
        pastEntriesTableView.dataSource = self
        dailyImageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
        category(.inspirationalQuote)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMyJournals()
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        dailyEntryTextView.resignFirstResponder()
    }
    
    func category(_ unsplashRoute: UnsplashRoute) {
        
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                //self.photos = photos
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
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        category(.inspirationalQuote)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let entry = dailyEntryTextView.text else { return }
        guard let userReferencce = UserController.shared.currentUser?.appleUserReference else { return }
        guard let urlString = self.photo?.urls.regular else { return }
        //guard let url = URL(string: urlString) else { return }
        DailyController.shared.createDailyJournal(imageURL: urlString, entry: entry, userReference: userReferencce) { (success) in
            print("Success saving a daily journal.")
        }
    }
    
}

// MARK: - Extensions
extension DailyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DailyController.shared.myDailyJournals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastDailyJournalEntry", for: indexPath)
        let entry = DailyController.shared.myDailyJournals[indexPath.row]
        cell.textLabel?.text = DateHelper.shared.mediumDateSTRfromDouble(dateDouble: entry.timestamp)
        return cell
    }
}
