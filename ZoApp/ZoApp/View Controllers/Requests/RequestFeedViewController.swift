//
//  RequestFeedViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class RequestFeedViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var pastRequestsTableView: UITableView!
    @IBOutlet weak var noPastMyRequestsLabel: UILabel!
    @IBOutlet weak var requestsLabel: UILabel!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var addNewRequestButton: UIButton!
    @IBOutlet weak var activeRequestsFeedTableView: UITableView!
    @IBOutlet weak var noPastAllRequestsLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myRequestsLabel: UILabel!
    @IBOutlet weak var allRequestsLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createTapGesture()
        activeRequestsFeedTableView.delegate = self
        activeRequestsFeedTableView.dataSource = self
        pastRequestsTableView.delegate = self
        pastRequestsTableView.dataSource = self
        searchBar.clearButtonMode = UITextField.ViewMode.always
        searchBar.delegate = self
        let notification = Notification.Name(rawValue: "reloadRequestTableViews")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRequestTableViews), name: notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRequestTableViews), name: NSNotification.Name("deletedResponse"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pastRequestsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecentlyCurrentUserRequests()
        fetchRequests()
        setupUI()
        hideOrDisplayLabels()
    }
    
    // MARK: - Custom Methods
    
    func createTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapResign() {
        searchBar.resignFirstResponder()
    }
    
    @objc func reloadRequestTableViews() {
        self.activeRequestsFeedTableView.reloadData()
        self.pastRequestsTableView.reloadData()
        hideOrDisplayLabels()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if searchBar.text == "" {
            RequestController.shared.fetchRequests { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.activeRequestsFeedTableView.reloadData()
                        print("Fetched requests")
                    }
                }
            }
        }
    }
    
    func hideOrDisplayLabels() {
        if RequestController.shared.myRequests.count == 0 {
            noPastMyRequestsLabel.isHidden = false
        } else if RequestController.shared.myRequests.count > 0 {
            noPastMyRequestsLabel.isHidden = true
        }
        
        if RequestController.shared.requests.count == 0 {
            noPastAllRequestsLabel.isHidden = false
        } else if RequestController.shared.requests.count > 0 {
            noPastAllRequestsLabel.isHidden = true
        }
    }
    
    func setupUI() {
        noPastMyRequestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h4.fontSize)
        noPastMyRequestsLabel.textColor = .blueGrey
        noPastAllRequestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h4.fontSize)
        noPastAllRequestsLabel.textColor = .blueGrey
        searchBar.addCornerRadius(13.0)
        searchBar.addAccentBorder(width: 2.0, color: .boldGreen)
        searchBar.layer.masksToBounds = true
        requestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        requestsLabel.textColor = .zoWhite
        addNewRequestButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        addNewRequestButton.contentHorizontalAlignment = .right
        myRequestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        myRequestsLabel.textColor = .blueGrey
        allRequestsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        allRequestsLabel.textColor = .blueGrey
        pastRequestsTableView.addAccentBorder(width: 2.0, color: .boldGreen)
        pastRequestsTableView.addCornerRadius(13.0)
    }
    
    func fetchRecentlyCurrentUserRequests() {
        RequestController.shared.fetchOnlyRecentCurrentUserRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    self.hideOrDisplayLabels()
                    self.pastRequestsTableView.reloadData()
                }
            }
        }
    }
    
    func fetchRequests() {
        RequestController.shared.fetchRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    self.hideOrDisplayLabels()
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
                        self.hideOrDisplayLabels()
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
                    }
                }
            }
        }
    }
}

// MARK: - Extensions
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
