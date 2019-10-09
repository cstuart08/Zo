//
//  DailyViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var pastEntriesTableView: UITableView!
    @IBOutlet weak var dailyEntryTextView: UITextView!
    
    // MARK: - Properties
        /// MOCK DATA
        let pastDailyEntries = ["OCT 3, 2019", "OCT 2, 2019", "OCT 1, 2019", "SEP 27, 2019", "SEP 26, 2019", "SEP 24, 2019", "SEP 22, 2019", "SEP 21, 2019"]
    let randomImages: [UIImage] = [UIImage(named: "canyonJump")!]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pastEntriesTableView.delegate = self
        pastEntriesTableView.dataSource = self
        dailyImageView.image = randomImages.randomElement()
        dailyImageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.pastEntriesTableView.reloadData()
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        dailyEntryTextView.resignFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        dailyImageView.image = randomImages.randomElement()
    }
}

// MARK: - Extensions
extension DailyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pastDailyEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastDailyJournalEntry", for: indexPath)
        let entry = pastDailyEntries[indexPath.row]
        cell.textLabel?.text = entry
        return cell
    }
}
