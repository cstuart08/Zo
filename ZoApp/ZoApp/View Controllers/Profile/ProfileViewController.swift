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
    @IBOutlet weak var chakraImageButton: UIButton!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pastRequestsTableView.delegate = self
        pastRequestsTableView.dataSource = self
        pastRequestsTableView.register(UINib(nibName: "myRequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "myRequest")
        stylizeSubviews()
        fetchRequests()
        guard let currentUser = UserController.shared.currentUser else { return }
        currentUser.kpPoints = 3500
        currentUser.kpLevel = Chakra.sacral.levelNames
        checkKarmaPointsToUpdateImageAndRankLabel(points: currentUser.kpPoints)
        let lastKarmaLevel = ChakraController.shared.chakraLevelsArray[currentUser.lastKarmaLevelIndex]
        if lastKarmaLevel != currentUser.kpLevel {
            displayKarmaPointsAlert()
            currentUser.lastKarmaLevelIndex += 1
        }
        setupViews()
    }
    
    // MARK: - Custom Methods
    
    func checkKarmaPointsToUpdateImageAndRankLabel(points: Int) {
        switch points {
        case _ where points < Chakra.sacral.pointLevels:
            rankLabel.text = Chakra.root.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.root.imageNames), for: .normal)
        case _ where points >= Chakra.sacral.pointLevels && points < Chakra.solarPlexus.pointLevels:
            rankLabel.text = Chakra.sacral.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.sacral.imageNames), for: .normal)
        case _ where points >= Chakra.solarPlexus.pointLevels && points < Chakra.heart.pointLevels:
            rankLabel.text = Chakra.solarPlexus.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.solarPlexus.imageNames), for: .normal)
        case _ where points >= Chakra.heart.pointLevels && points < Chakra.throat.pointLevels:
            rankLabel.text = Chakra.heart.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.heart.imageNames), for: .normal)
        case _ where points >= Chakra.throat.pointLevels && points < Chakra.thirdEye.pointLevels:
            rankLabel.text = Chakra.throat.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.throat.imageNames), for: .normal)
        case _ where points >= Chakra.thirdEye.pointLevels && points < Chakra.crown.pointLevels:
            rankLabel.text = Chakra.thirdEye.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.thirdEye.imageNames), for: .normal)
        case _ where points >= Chakra.crown.pointLevels:
            rankLabel.text = Chakra.crown.levelNames
            chakraImageButton.setImage(UIImage(named: Chakra.crown.imageNames), for: .normal)
        default:
            print("Nothing to update for their Karma Points.")
        }
    }
    
    func displayKarmaPointsAlert() {
        guard let viewController = UIStoryboard(name: "PointsAndRank", bundle: nil).instantiateViewController(withIdentifier: "pointsAndRankStoryBoard") as? PointsAndRankVC else { return }
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    // MARK: - Setup Views
    func setupViews() {
        guard let currentUser = UserController.shared.currentUser else { return }
        usernameLabel.text = currentUser.username
        pointsLabel.text = "\(currentUser.kpPoints) KP"
    }
    
    func fetchRequests() {
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
        rankLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        rankLabel.textColor = .blueGrey
        pointsLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        pointsLabel.textColor = .blueGrey
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        usernameLabel.textColor = .blueGrey
    }
    
    
    // MARK: - Actions
    @IBAction func profileOptionsButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://cameronstuart.com/zo-support") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @IBAction func chakraImageButtonTapped(_ sender: Any) {
        displayKarmaPointsAlert()
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
