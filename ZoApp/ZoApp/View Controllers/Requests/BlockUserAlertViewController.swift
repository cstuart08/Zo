//
//  BlockUserAlertViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class BlockUserAlertViewController: UIViewController {
    
    var response: Response? {
        didSet {
            print("oooooooooohhhhhh yeyyyeyayeyeyyeahah ")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        deleteResponse()
        self.dismiss(animated: true)
    }
    
    // MARK: - Custom Methods
    func deleteResponse() {
        guard let response = response, let currentUser = UserController.shared.currentUser else { return }
        ResponseController.shared.deleteResponse(response: response) { (success) in
            if success {
                DispatchQueue.main.async {
                    currentUser.isBlocked.append(response.username)
                    UserController.shared.modifyRecordsOperation(user: currentUser) { (success) in
                        if success {
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletedResponse"), object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
