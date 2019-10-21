//
//  RespondToRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class RespondToRequestViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // MARK: - Outlets
    // Request
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var imageSelectorImageView: UIImageView!
    @IBOutlet weak var requestTag1: UILabel!
    @IBOutlet weak var requestTag2: UILabel!
    @IBOutlet weak var requestTag3: UILabel!
    
    // Response
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var responseTextAndButtonsView: UIView!
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
    var randomImages: [UIImage] = [UIImage(named: "quote1")!, UIImage(named: "quote2")!, UIImage(named: "quote3")!, UIImage(named: "quote4")!, UIImage(named: "quote5")!, UIImage(named: "quote6")!, UIImage(named: "quote7")!, UIImage(named: "quote8")!, UIImage(named: "quote9")!, UIImage(named: "quote10")!, UIImage(named: "quote11")!, UIImage(named: "quote12")!, UIImage(named: "quote13")!]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addLinkTextField.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapResign))
        view.addGestureRecognizer(tap)
        responseTextView.delegate = self
        addSongButton.isHidden = true
        imageSelectorImageView.isHidden = true
    }
    
     // MARK: - Custom Methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        if responseTextView.text == "Enter your response here..." {
            responseTextView.text = nil
            responseTextView.textColor = UIColor.blueGrey
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if responseTextView.text.isEmpty {
            responseTextView.text = "Enter your response here..."
            responseTextView.textColor = UIColor.blueGrey
        }
    }
    
        func setupViews() {
            loadViewIfNeeded()
            guard let request = request else { return }
            requestImageView.image = request.image
            answerView.addAccentBorder(width: 2.0, color: .boldGreen)
            answerView.addCornerRadius(8.0)
            answerView.backgroundColor = UIColor.sageGreen.withAlphaComponent(1.0)
            requestTextView.setupDailyTextViewUI()
            responseTextAndButtonsView.addAccentBorder(width: 2.0, color: .boldGreen)
            responseTextAndButtonsView.addCornerRadius(8.0)
            requestTextView.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
            requestTextView.textColor = .blueGrey
            yourAnswerLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
            yourAnswerLabel.textColor = .blueGrey
            usernameLabel.text = request.username
            usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
            usernameLabel.textColor = .zoWhite
            numberOfResponsesLabel.text = "\(request.responseCount)"
            requestTextView.text = request.body
            requestTextView.isSelectable = false
            requestTextView.isEditable = false
            requestTag1.text = request.tags[0]
            requestTag2.text = request.tags[1]
            requestTag3.text = request.tags[2]
            requestTag1.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
            requestTag1.textColor = .blueGrey
            requestTag1.addAccentBorder(width: 2.0, color: .boldGreen)
            requestTag1.addCornerRadius(8)
            requestTag1.layer.masksToBounds = true
            requestTag2.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
            requestTag2.textColor = .blueGrey
            requestTag2.addAccentBorder(width: 2.0, color: .boldGreen)
            requestTag2.addCornerRadius(8)
            requestTag2.layer.masksToBounds = true
            requestTag3.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
            requestTag3.textColor = .blueGrey
            requestTag3.addAccentBorder(width: 2.0, color: .boldGreen)
            requestTag3.addCornerRadius(8)
            requestTag3.layer.masksToBounds = true
            requestImageView.addCornerRadius()
            numberOfResponsesLabel.addCornerRadius(6)
            numberOfResponsesLabel.backgroundColor = .darkBlue
            numberOfResponsesLabel.font = UIFont(name: FontAttributes.number.fontFamily, size: FontAttributes.number.fontSize)
            numberOfResponsesLabel.layer.masksToBounds = true
            responseTextView.addPadding()
            addLinkTextField.addAccentBorder(width: 2.0, color: .blueGrey)
            addLinkTextField.addCornerRadius(6.0)
            imageSelectorImageView.addCornerRadius(13.0)
            imageSelectorImageView.addAccentBorder(width: 2.0, color: .boldGreen)
            imageSelectorImageView.layer.masksToBounds = true
        }
        
        
        
        // MARK: - Actions
        @IBAction func cancelButtonTapped(_ sender: Any) {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
        
        // MARK: - UI Adjustments
        @objc func tapResign() {
            view.frame.origin.y = 0
            responseTextView.resignFirstResponder()
            addLinkTextField.resignFirstResponder()
        }
        
        @objc func keyboardWillShow() {
            view.frame.origin.y = -(view.frame.height / 5)
        }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
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
        selectImageActionSheet()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let currentUser = UserController.shared.currentUser,
            let request = request,
            let link = addLinkTextField.text,
            let bodyText = responseTextView.text, !bodyText.isEmpty else { return }
        let image = imageSelectorImageView.image
        let requestReference = CKRecord.Reference(recordID: request.recordID, action: .deleteSelf)
        ResponseController.shared.createResponse(username: currentUser.username, bodyText: bodyText, link: link, image: image, responseTags: ["tag"], requestReference: requestReference) { (success) in
            if success {
                request.responseCount += 1
                RequestController.shared.modifyRecordsOperation(request: request) { (success) in
                    if success {
                        UserController.shared.fetchUser { (success) in
                            if success {
                                guard let upToDateUser = UserController.shared.currentUser else { return }
                                upToDateUser.respondedTo.append(request.recordID.recordName)
                                ChakraController.shared.addKarmaPointsForResponse(user: upToDateUser)
                                print("Added +50 points to \(upToDateUser.username)")
                                DispatchQueue.main.async {
                                    print("response count was modified in the record")
                                    self.dismiss(animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    func selectImageActionSheet() {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let action2 = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(action2)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            imageSelectorImageView.image = pickedImage
            imageSelectorImageView.isHidden = false
        }
        dismiss(animated: true, completion: nil)
    }
}
