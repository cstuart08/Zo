//
//  UsernameOnboardingViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class UsernameOnboardingViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createUsernameTextField: UITextField!
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
        stylizeSubviews()
        createUsernameTextField.delegate = self
        fetchAllUsers()
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        createUsernameTextField.resignFirstResponder()
    }
    
    func fetchAllUsers() {
        UsernameController.shared.fetchAllUsernames { (success) in
            if success {
                print("Success fetching all usernames")
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let username = createUsernameTextField.text, !username.isEmpty else { return }
        let usernamelowercased = username.lowercased()
        if UsernameController.shared.usernames.contains(usernamelowercased) == true {
            createUsernameTextField.text = ""
            createUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Sorry! This user already exists.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            print("Username already exists.")
        } else {
            UserController.shared.createUser(username: username) { (success) in
                if success {
                    print("User created.")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                        let tabViewController = storyboard.instantiateViewController(withIdentifier: "TabController")
                        self.present(tabViewController, animated: true, completion: nil)
                    }
                } else {
                    print("User was not created.")
                }
            }
        }
    }
    
    // MARK: - UI Adjustments
    func textFieldDidBeginEditing(_ textField: UITextField) {
        createUsernameTextField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if createUsernameTextField.text == "" {
            createUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Enter Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.zoWhite])
        }
    }
    
    func stylizeSubviews() {
        view.backgroundColor = .boldGreen
        titleLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        titleLabel.textColor = .zoWhite
        disclaimerLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        disclaimerLabel.textColor = .zoWhite
    }
}
