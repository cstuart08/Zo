//
//  ActiveRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class ActiveRequestViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyTextView: UITextView!
    @IBOutlet weak var responsesTableView: UITableView!
    @IBOutlet weak var tagOne: ZoLabel!
    @IBOutlet weak var tagTwo: ZoLabel!
    @IBOutlet weak var tagThree: ZoLabel!
    @IBOutlet weak var topLabel: UILabel!
    
    // MARK: - Properties
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .ivory
        responsesTableView.delegate = self
        responsesTableView.dataSource = self
        fetchResponses()
    }

    // MARK: - Custom Methods
    func fetchResponses() {
        guard let request = request else { return }
        
        ResponseController.shared.fetchResponses(request: request) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.responsesTableView.reloadData()
                }
            }
        }
    }
    
    func setupViews() {
        loadViewIfNeeded()
        guard let request = request else { return }
        topLabel.text = request.username
        topLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        topLabel.textColor = .zoWhite
        requestBodyTextView.setupDailyTextViewUI()
        requestBodyTextView.text = request.body
        requestImageView.image = UIImage(named: "focus")
        numberOfResponsesLabel.text = "\(request.responseCount)"
        tagOne.text = request.tags[0]
        tagTwo.text = request.tags[1]
        tagThree.text = request.tags[2]
        tagOne.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.rawValue)
        tagOne.textColor = .blueGrey
        tagOne.addAccentBorder(width: 2.0, color: .boldGreen)
        tagOne.addCornerRadius(8)
        tagOne.layer.masksToBounds = true
        tagTwo.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.rawValue)
        tagTwo.textColor = .blueGrey
        tagTwo.addAccentBorder(width: 2.0, color: .boldGreen)
        tagTwo.addCornerRadius(8)
        tagTwo.layer.masksToBounds = true
        tagThree.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.rawValue)
        tagThree.textColor = .blueGrey
        tagThree.addAccentBorder(width: 2.0, color: .boldGreen)
        tagThree.addCornerRadius(8)
        tagThree.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - Extensions
extension ActiveRequestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponseController.shared.responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "responseCell", for: indexPath) as? ResponseTableViewCell else { return UITableViewCell()}
        
        let response = ResponseController.shared.responses[indexPath.row]
        
        cell.response = response
        
        return cell
    }
}
