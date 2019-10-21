//
//  CreateRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class CreateRequestViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var add3TagsLabel: UILabel!
    @IBOutlet weak var hashtagTextField1: UITextField!
    @IBOutlet weak var hashtagTextField2: UITextField!
    @IBOutlet weak var hashtagTextField3: UITextField!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var requestHeader: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var hashtag1: UILabel!
    @IBOutlet weak var hashtag2: UILabel!
    @IBOutlet weak var hashtag3: UILabel!
    
    // MARK: - Properites
    let user = UserController.shared.currentUser
    
    let randomImages: [UIImage] = [UIImage(named: "nature1")!, UIImage(named: "nature2")!, UIImage(named: "nature3")!, UIImage(named: "nature4")!, UIImage(named: "nature5")!, UIImage(named: "nature6")!, UIImage(named: "nature7")!, UIImage(named: "nature8")!, UIImage(named: "nature9")!, UIImage(named: "nature10")!, UIImage(named: "nature11")!, UIImage(named: "nature12")!, UIImage(named: "nature13")!, UIImage(named: "nature14")!, UIImage(named: "nature15")!, UIImage(named: "nature16")!, UIImage(named: "nature17")!, UIImage(named: "nature18")!, UIImage(named: "nature19")!]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableRequestButton), name: NSNotification.Name("lostNetworkDismissed"), object: nil)
        requestTextView.delegate = self
        createTapGesture()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        requestButton.isEnabled = true
     }
    
    // MARK: - Methods
    @objc func enableRequestButton() {
        requestButton.isEnabled = true
    }
    
    @objc func keyboardWillShow() {
        view.frame.origin.y = -(view.frame.height / 6)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if requestTextView.text == "Enter your request here..." {
            requestTextView.text = nil
            requestTextView.textColor = UIColor.blueGrey
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if requestTextView.text.isEmpty {
            requestTextView.text = "Enter your request here..."
            requestTextView.textColor = UIColor.blueGrey
        }
    }
    
    func setupUI() {
        guard let user = user else { return }
        usernameLabel.text = user.username
        // Background View
        self.view.backgroundColor = .ivory
        // Request Header Label
        requestHeader.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        requestHeader.textColor = .zoWhite
        // Cancel Button
        cancelButton.titleLabel?.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.body.fontSize)
        // Hashtag symbols
        hashtag1.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        hashtag1.textColor = .boldGreen
        hashtag2.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        hashtag2.textColor = .boldGreen
        hashtag3.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        hashtag3.textColor = .boldGreen
        // Username Label
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        usernameLabel.textColor = .blueGrey
        usernameLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        usernameLabel.addCornerRadius(8.0)
        usernameLabel.backgroundColor = .zoWhite
        usernameLabel.layer.masksToBounds = true
        usernameLabel.textAlignment = .left
        // Add Up To 3 Tags Label
        add3TagsLabel.font = UIFont(name: FontAttributes.h3.fontFamily, size: FontAttributes.h3.fontSize)
        add3TagsLabel.textColor = .blueGrey
        add3TagsLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        add3TagsLabel.addCornerRadius(8.0)
        add3TagsLabel.backgroundColor = .zoWhite
        add3TagsLabel.layer.masksToBounds = true
        add3TagsLabel.textAlignment = .center
        // Hashtag Text Field #1
        hashtagTextField1.font = UIFont(name: FontAttributes.h4.fontFamily, size: FontAttributes.h4.fontSize)
        hashtagTextField1.textColor = .blueGrey
        hashtagTextField1.addAccentBorder(width: 2.0, color: .boldGreen)
        hashtagTextField1.addCornerRadius(8.0)
        hashtagTextField1.backgroundColor = .zoWhite
        hashtagTextField1.layer.masksToBounds = true
        // Hashtag Text Field #2
        hashtagTextField2.font = UIFont(name: FontAttributes.h4.fontFamily, size: FontAttributes.h4.fontSize)
        hashtagTextField2.textColor = .blueGrey
        hashtagTextField2.addAccentBorder(width: 2.0, color: .boldGreen)
        hashtagTextField2.addCornerRadius(8.0)
        hashtagTextField2.backgroundColor = .zoWhite
        hashtagTextField2.layer.masksToBounds = true
        // Hashtag Text Field #3
        hashtagTextField3.font = UIFont(name: FontAttributes.h4.fontFamily, size: FontAttributes.h4.fontSize)
        hashtagTextField3.textColor = .blueGrey
        hashtagTextField3.addAccentBorder(width: 2.0, color: .boldGreen)
        hashtagTextField3.addCornerRadius(8.0)
        hashtagTextField3.backgroundColor = .zoWhite
        hashtagTextField3.layer.masksToBounds = true
        // Request Text View
        requestTextView.backgroundColor = .zoWhite
        requestTextView.addCornerRadius(13.0)
        requestTextView.addAccentBorder(width: 2.5, color: .boldGreen)
        requestTextView.addPadding()
        requestTextView.layer.masksToBounds = true
        requestTextView.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        requestTextView.textColor = .blueGrey
    }
    
    func createTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapResign() {
        view.frame.origin.y = 0
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
        requestButton.isEnabled = false
        if Reachability.isConnectedToNetwork() {
            guard let username = usernameLabel.text,
                let body = requestTextView.text,
                let hashtag1 = hashtagTextField1.text,
                let hashtag2 = hashtagTextField2.text,
                let hashtag3 = hashtagTextField3.text else { return }
            guard let user = user else { return }
            let userRef = CKRecord.Reference(recordID: user.recordID, action: .deleteSelf)
            guard let randomImage = randomImages.randomElement() else { return }
            RequestController.shared.createAndSaveRequest(image: randomImage, title: "No Title Field Currently", username: username, body: body, userReference: userRef, tags: ["#" + hashtag1, "#" + hashtag2, "#" + hashtag3]) { (success) in
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
        } else {
            let viewController = UIStoryboard(name: "NoNetworkFound", bundle: nil).instantiateViewController(withIdentifier: "LostNetworkSB") as! LostNetworkViewController
            self.present(viewController, animated: true)
        }
    }
}
