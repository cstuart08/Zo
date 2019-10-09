//
//  RespondToRequestViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
import CloudKit

class RespondToRequestViewController: UIViewController {

    
    // MARK: - Outlets
    
    // Request
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    
    // Response
    @IBOutlet weak var yourAnswerLabel: UILabel!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var addLinkButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var addLinkTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    // MARK: - Properties
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    
    // MARK: - Lifecycle Methods


    override func viewDidLoad() {
        super.viewDidLoad()

        addLinkTextField.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addLinkButtonTapped(_ sender: Any) {
        if addLinkTextField.isHidden == false {
            addLinkTextField.isHidden = true
        } else if addLinkTextField.isHidden == true {
            addLinkTextField.isHidden = false
        }
    }
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let currentUser = UserController.shared.currentUser,
            let request = request,
            let link = addLinkTextField.text,
            let linkURL = URL(string: link),
            let bodyText = requestBodyLabel.text, !bodyText.isEmpty else { return }
        let requestReference = CKRecord.Reference(recordID: request.recordID, action: .deleteSelf)
        ResponseController.shared.createResponse(username: currentUser.username, bodyText: bodyText, link: linkURL, image: nil, responseTags: request.tags, requestReference: requestReference) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    func setupViews() {
        loadViewIfNeeded()
        usernameLabel.text = request?.username
        numberOfResponsesLabel.text = "\(ResponseController.shared.responses.count)"
        requestBodyLabel.text = request?.body
        
        
    }
    
    
    // MARK: - UI Adjustments

    
    @objc func tapResign() {
        view.frame.origin.y = 0
        responseTextView.resignFirstResponder()
        addLinkTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow() {
        view.frame.origin.y = -(view.frame.height / 3.5)
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
