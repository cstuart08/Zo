//
//  ProfileViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
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
        setupViews()
        
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
        pointsLabel.text = "\(100) KP Points"
    }

    
    // MARK: - Actions
    @IBAction func profileOptionsButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://cameronstuart.com/zo-support") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileMockDataController.shared.mockDataObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pastRequestCell", for: indexPath) as? ProfileViewCell else { return UITableViewCell() }
        
        let request = ProfileMockDataController.shared.mockDataObjects[indexPath.row]
        
        cell.request = request
        
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
