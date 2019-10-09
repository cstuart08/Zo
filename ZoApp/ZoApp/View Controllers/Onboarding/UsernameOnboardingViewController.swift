//
//  UsernameOnboardingViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class UsernameOnboardingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var createUsernameTextField: UITextField!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        createUsernameTextField.resignFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let username = createUsernameTextField.text, createUsernameTextField.text != nil else { return }
        UserController.shared.createUser(username: username) { (success) in
            if success {
                print("User created.")
            } else {
                print("User was not created.")
            }
        }
    }
}
