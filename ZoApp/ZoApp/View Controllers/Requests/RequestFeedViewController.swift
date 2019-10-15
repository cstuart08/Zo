//
//  RequestFeedViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class RequestFeedViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pastRequestsTableView: UITableView!
    @IBOutlet weak var requestsLabel: UILabel!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var addNewRequestButton: UIButton!
    @IBOutlet weak var activeRequestsFeedTableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sectionDivider: UIView!
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeRequestsFeedTableView.delegate = self
        activeRequestsFeedTableView.dataSource = self
        pastRequestsTableView.delegate = self
        pastRequestsTableView.dataSource = self
        requestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        requestsLabel.textColor = .zoWhite
        addNewRequestButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        addNewRequestButton.contentHorizontalAlignment = .right
        tagsView.isHidden = true
        sectionDivider.layer.cornerRadius = 5
        let notification = Notification.Name(rawValue: "reloadRequestTableViews")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRequestTableViews), name: notification, object: nil)
        fetchRecentlyCurrentUserRequests()
        fetchRequests()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pastRequestsTableView.reloadData()
    }
    
    // MARK: - Custom Methods
    @objc func reloadRequestTableViews() {
        self.activeRequestsFeedTableView.reloadData()
        self.pastRequestsTableView.reloadData()
    }
    
    func fetchRecentlyCurrentUserRequests() {
        RequestController.shared.fetchOnlyRecentCurrentUserRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    
                    self.pastRequestsTableView.reloadData()
                }
            }
        }
    }
    
    func fetchRequests() {
        RequestController.shared.fetchRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    self.activeRequestsFeedTableView.reloadData()
                    print("Fetched requests")
                }
            } else {
                print("Failed to fetch requests.")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewActivePastRequest" {
            if let index = pastRequestsTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? ActiveRequestViewController else { return }
                let requestToSend = RequestController.shared.myRequests[index.row]
                destinationVC.request = requestToSend
            }
        } else if segue.identifier == "toResponseToRequest" {
            if let index = activeRequestsFeedTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? RespondToRequestViewController else { return }
                let requestToSend = RequestController.shared.requests[index.row]
                destinationVC.request = requestToSend
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func rulesButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addNewRequestButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchBar.resignFirstResponder()
        guard let searchTag = searchBar.text else { return }
        if searchTag == "" {
            RequestController.shared.fetchRequests { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.activeRequestsFeedTableView.reloadData()
                        print("Fetched requests")
                    }
                } else {
                    print("Failed to fetch requests.")
                }
            }
        } else {
            RequestController.shared.fetchRequestsWithTag(tag: "#" + searchTag) { (success) in
                if success {
                    DispatchQueue.main.async {
                        print("Success fetching requests with tag")
                        self.activeRequestsFeedTableView.reloadData()
                        self.searchBar.text = nil
                    }
                }
            }
        }
    }
    
    // MARK: - UI Adjustments
}

extension RequestFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == pastRequestsTableView {
            return RequestController.shared.myRequests.count
        } else {
            return RequestController.shared.requests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == pastRequestsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "activePastRequestCell", for: indexPath) as? PastRequestsTableViewCell else { return UITableViewCell()}
            
            let request = RequestController.shared.myRequests[indexPath.row]
            
            cell.requestLandingPad = request
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "activeRequestCell", for: indexPath) as? ActiveRequestsTableViewCell else { return UITableViewCell()}
            
            let request = RequestController.shared.requests[indexPath.row]
            
            cell.requestLandingPad = request
            
            return cell
        }
    }
}


// MARK: - Mock Data

class ProfileMockDataModel1 {
    let text: String
    let image: UIImage?
    
    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
}

class ProfileMockDataController1 {
    static let shared = ProfileMockDataController1()
    
    var mockDataObjects = [ProfileMockDataModel1]()
    
    init() {
        
        let request1 = ProfileMockDataModel1(text: "#whatever #amiseeingthings #iphoneForTheWin", image: UIImage(named: "mountain"))
        let request2 = ProfileMockDataModel1(text: "#customTableViews #BadDay #WorkSucks", image: UIImage(named: "focus"))
        let request3 = ProfileMockDataModel1(text: "#DoesItWork #WAterIsLife #RAinbow", image: UIImage(named: "canyonJump"))
        
        self.mockDataObjects = [request1, request2, request3]
    }
    
    
}

class ProfileMockDataController2 {
    static let shared = ProfileMockDataController2()
    
    var mockDataObjects = [ProfileMockDataModel1]()
    
    init() {
        
        let request1 = ProfileMockDataModel1(text: "#whatever #amiseeingthings #iphoneForTheWin", image: UIImage(named: "mountain"))
        let request2 = ProfileMockDataModel1(text: "#customTableViews #BadDay #WorkSucks", image: UIImage(named: "focus"))
        let request3 = ProfileMockDataModel1(text: "#DoesItWork #WAterIsLife #RAinbow", image: UIImage(named: "canyonJump"))
        
        self.mockDataObjects = [request1, request2, request3]
    }
    
    
}
