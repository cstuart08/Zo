//
//  CreateRequestViewController.swift
//  JustBreateApp
//
//  Created by Apps on 10/8/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class CreateRequestViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hashtagTextField1: UITextField!
    @IBOutlet weak var hashtagTextField2: UITextField!
    @IBOutlet weak var hashtagTextField3: UITextField!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    
    // MARK: - Properites
    let user = UserController.shared.currentUser
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        createTapGesture()
        guard let user = user else { return }
        usernameLabel.text = user.username
    }
    
    // MARK: - Methods
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
    @IBAction func requestButtonTapped(_ sender: Any) {
        guard let username = usernameLabel.text else { return }
        guard let body = requestTextView.text else { return }
        guard let user = user else { return }
        RequestController.shared.createAndSaveRequest(title: "No Title Field Currently", username: username, body: body, userReference: user.appleUserReference) { (success) in
            if success {
                print("Success creating a request.")
                self.dismiss(animated: true)
            } else {
                print("Uh oh! -------------------- \n Request not created. \n ----------------")
            }
        }
    }
}
