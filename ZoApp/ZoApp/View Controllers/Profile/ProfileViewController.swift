//
//  ProfileViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit
import SafariServices

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var pastRequestsTableView: UITableView!
    
    // MARK: - Properties
    let currentUser = UserController.shared.currentUser
    var points = 20000
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pastRequestsTableView.delegate = self
        pastRequestsTableView.dataSource = self
        pastRequestsTableView.register(UINib(nibName: "myRequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "myRequest")
        setupViews()
        stylizeSubviews()
        fetchRequests()
        guard let currentUser = currentUser else { return }
        currentUser.kpPoints = points
        if points == 20000 {
            guard let viewController = UIStoryboard(name: "PointsAndRank", bundle: nil).instantiateViewController(withIdentifier: "pointsAndRankStoryBoard") as? PointsAndRankVC else { return }
            self.present(viewController, animated: true, completion: nil)
            
            points += 5
        }
    }
    
    
    // MARK: - Setup Views
    func setupViews() {
        rankLabel.text = "Gold Rank"
        pointsLabel.text = "\(10000) KP"
        rankLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        rankLabel.textColor = .blueGrey
        pointsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        pointsLabel.textColor = .blueGrey
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        usernameLabel.textColor = .blueGrey
    }
    func fetchRequests() {
        //        guard let userRecordID = UserController.shared.currentUser?.recordID else { return }
        //        let userRef = CKRecord.Reference(recordID: userRecordID, action: .deleteSelf)
        RequestController.shared.fetchAllCurrentUserRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    self.pastRequestsTableView.reloadData()
                }
            }
        }
    }
    
    func stylizeSubviews() {
        view.backgroundColor = .ivory
    }

    
    // MARK: - Actions
    @IBAction func profileOptionsButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://cameronstuart.com/zo-support") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestController.shared.myRequests.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = RequestController.shared.myRequests[indexPath.row]
        guard let destinationVC = UIStoryboard(name: "Requests", bundle: nil).instantiateViewController(identifier: "requestDetailVC") as? ActiveRequestViewController else { return }
        destinationVC.request = request
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRequest", for: indexPath) as? myRequestsTableViewCell else { return UITableViewCell() }
        
        let request = RequestController.shared.myRequests[indexPath.row]
        
        cell.requestLandingPad = request
        
        return cell
        
    }
}

// MARK: - Mock Data
class ProfileMockDataModel {
    let text: String
    let image: UIImage?
    
    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
}

class ProfileMockDataController {
    static let shared = ProfileMockDataController()
    
    var mockDataObjects = [ProfileMockDataModel]()
    
    init() {
        
        let request1 = ProfileMockDataModel(text: "description 1", image: UIImage(named: "mountain"))
        let request2 = ProfileMockDataModel(text: "description 2", image: UIImage(named: "focus"))
        let request3 = ProfileMockDataModel(text: "description 3", image: UIImage(named: "canyonJump"))
        
        self.mockDataObjects = [request1, request2, request3]
    }
    
    
}
