//
//  RespondToRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class RespondToRequestViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: - Outlets
    
    // Request
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var imageSelectorImageView: UIImageView!
    
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
        selectImageActionSheet()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let currentUser = UserController.shared.currentUser,
            let request = request,
            let link = addLinkTextField.text,
            let bodyText = responseTextView.text, !bodyText.isEmpty,
            let image = UIImage(named: "focus") else { return }
        let requestReference = CKRecord.Reference(recordID: request.recordID, action: .deleteSelf)
        ResponseController.shared.createResponse(username: currentUser.username, bodyText: bodyText, link: link, image: image, responseTags: ["tag"], requestReference: requestReference) { (success) in
            if success {
                request.responseCount += 1
                RequestController.shared.modifyRecordsOperation(request: request) { (success) in
                    if success {
                        DispatchQueue.main.async {
                            print("response count was modified in the record")
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    func setupViews() {
        loadViewIfNeeded()
        guard let request = request else { return }
        usernameLabel.text = request.username
        numberOfResponsesLabel.text = "\(request.responseCount)"
        requestBodyLabel.text = request.body
        
        
    }
    
    func selectImageActionSheet() {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let action1 = UIAlertAction(title: "Camera", style: .default) { (_) in
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .rear
            self.present(imagePickerController, animated: true)
        }
        
        let action2 = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            imageSelectorImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
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
