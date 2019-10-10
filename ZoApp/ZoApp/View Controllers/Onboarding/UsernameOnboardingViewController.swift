//
//  UsernameOnboardingViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class UsernameOnboardingViewController: UIViewController {

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
    }
    
    // MARK: - Methods
    @objc func tapResign() {
        createUsernameTextField.resignFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let username = createUsernameTextField.text, !username.isEmpty else { return }
        
        // MARK: - TODO
        // TODO: - Need to check if the username already exists
        
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
                // MARK: - TODO
                // TODO: - Create alert saying they need to enter a username
            }
        }
    }
    
    
    // MARK: - UI Adjustments
    
    func stylizeSubviews() {
        view.backgroundColor = .boldGreen
        titleLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.rawValue)
        titleLabel.textColor = .zoWhite
        disclaimerLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.rawValue)
        disclaimerLabel.textColor = .zoWhite
    }

}
