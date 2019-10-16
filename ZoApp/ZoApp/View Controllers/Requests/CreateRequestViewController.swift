//
//  CreateRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class CreateRequestViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hashtagTextField1: UITextField!
    @IBOutlet weak var hashtagTextField2: UITextField!
    @IBOutlet weak var hashtagTextField3: UITextField!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var requestHeader: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Properites
    let user = UserController.shared.currentUser
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        createTapGesture()
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI() {
        guard let user = user else { return }
        usernameLabel.text = user.username
        self.view.backgroundColor = .ivory
        requestHeader.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        requestHeader.textColor = .zoWhite
        cancelButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.body.fontSize)
    }
    
    func createTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapResign() {
        hashtagTextField1.resignFirstResponder()
        hashtagTextField2.resignFirstResponder()
        hashtagTextField3.resignFirstResponder()
        requestTextView.resignFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func rulesButtonTapped(_ sender: Any) {
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    
    @IBAction func requestButtonTapped(_ sender: Any) {
        guard let username = usernameLabel.text,
            let body = requestTextView.text,
            let hashtag1 = hashtagTextField1.text,
            let hashtag2 = hashtagTextField2.text,
            let hashtag3 = hashtagTextField3.text else { return }
        guard let user = user else { return }
        let userRef = CKRecord.Reference(recordID: user.recordID, action: .deleteSelf)
        RequestController.shared.createAndSaveRequest(title: "No Title Field Currently", username: username, body: body, userReference: userRef, tags: ["#" + hashtag1, "#" + hashtag2, "#" + hashtag3]) { (success) in
            if success {
                DispatchQueue.main.async {
                    print("Success creating a request.")
                    let notification = Notification(name: Notification.Name(rawValue: "reloadRequestTableViews"))
                    NotificationCenter.default.post(notification)
                    self.dismiss(animated: true)
                }
            } else {
                print("Uh oh! -------------------- \n Request not created. \n ----------------")
            }
        }
    }
}
