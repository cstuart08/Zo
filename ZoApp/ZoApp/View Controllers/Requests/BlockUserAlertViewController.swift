//
//  BlockUserAlertViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class BlockUserAlertViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var blockThisUserLabel: UILabel!
    @IBOutlet weak var blockUserWarningLabel: UILabel!
    
    
    // MARK: - Properties
    var response: Response? {
        didSet {
            print("Response Set.")
        }
    }

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Custom Methods
    func deleteResponse() {
        guard let response = response else { return }
        ResponseController.shared.deleteResponse(response: response) { (success) in
            if success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletedResponse"), object: nil)
                }
            }
        }
    }
    
    func setupUI() {
        blockThisUserLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        blockThisUserLabel.textColor = .zoWhite
        blockUserWarningLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        blockUserWarningLabel.textColor = .zoWhite
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        deleteResponse()
        self.dismiss(animated: true)
    }
}
