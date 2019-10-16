//
//  ActiveRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import MessageUI
import CloudKit

class ActiveRequestViewController: UIViewController, MFMailComposeViewControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyTextView: UITextView!
    @IBOutlet weak var responsesTableView: UITableView!
    @IBOutlet weak var tagOne: ZoLabel!
    @IBOutlet weak var tagTwo: ZoLabel!
    @IBOutlet weak var tagThree: ZoLabel!
    @IBOutlet weak var topLabel: UILabel!
    
    // MARK: - Properties
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    
    var response: Response?
    
    var randomImages: [UIImage] = [UIImage(named: "quote1")!, UIImage(named: "quote2")!, UIImage(named: "quote3")!, UIImage(named: "quote4")!, UIImage(named: "quote5")!, UIImage(named: "quote6")!, UIImage(named: "quote7")!, UIImage(named: "quote8")!, UIImage(named: "quote9")!, UIImage(named: "quote10")!, UIImage(named: "quote11")!, UIImage(named: "quote12")!, UIImage(named: "quote13")!]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .ivory
        responsesTableView.delegate = self
        responsesTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(activateMailComposer), name: NSNotification.Name("showMailComposer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: NSNotification.Name("deletedResponse"), object: nil)
        fetchResponses()
    }

    // MARK: - Custom Methods
    func fetchResponses() {
        guard let request = request else { return }
        
        ResponseController.shared.fetchResponses(request: request) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.responsesTableView.reloadData()
                }
            }
        }
    }
    
    @objc func reloadViews() {
        self.responsesTableView.reloadData()
    }
    
    func setupViews() {
        loadViewIfNeeded()
        guard let request = request else { return }
        responsesTableView.addAccentBorder(width: 2.0, color: .boldGreen)
        responsesTableView.addCornerRadius(13)
        topLabel.text = request.username
        topLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        topLabel.textColor = .zoWhite
        requestBodyTextView.setupDailyTextViewUI()
        requestBodyTextView.text = request.body
        requestImageView.image = randomImages.randomElement()
        numberOfResponsesLabel.text = "\(request.responseCount)"
        tagOne.text = request.tags[0]
        tagTwo.text = request.tags[1]
        tagThree.text = request.tags[2]
        tagOne.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        tagOne.textColor = .blueGrey
        tagOne.addAccentBorder(width: 2.0, color: .boldGreen)
        tagOne.addCornerRadius(8)
        tagOne.layer.masksToBounds = true
        tagTwo.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        tagTwo.textColor = .blueGrey
        tagTwo.addAccentBorder(width: 2.0, color: .boldGreen)
        tagTwo.addCornerRadius(8)
        tagTwo.layer.masksToBounds = true
        tagThree.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        tagThree.textColor = .blueGrey
        tagThree.addAccentBorder(width: 2.0, color: .boldGreen)
        tagThree.addCornerRadius(8)
        tagThree.layer.masksToBounds = true
    }
    
    @objc func activateMailComposer() {
        showMailCompoesr()
    }
    
    func showMailCompoesr() {
        guard let request = request else { return }
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let letterComposer = MFMailComposeViewController()
        letterComposer.mailComposeDelegate = self
        letterComposer.setSubject("Report this user ID: \(request.userReference.recordID.recordName)")
        letterComposer.setToRecipients(["apps@cameronstuart.com"])
        letterComposer.setMessageBody("I would like to report this user: \(request.userReference.recordID.recordName) (Dont delete this ID)", isHTML: false)
        
        present(letterComposer, animated: true)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
             controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            print("Saved")
        case .sent:
            print("Sent")
        case .failed:
            print("Failed")
        default:
            print("game over")
        }
        
    controller.dismiss(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - Extensions
extension ActiveRequestViewController: UITableViewDataSource, UITableViewDelegate, responseTVCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResponseController.shared.responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "responseCell", for: indexPath) as? ResponseTableViewCell else { return UITableViewCell()}
        
        let response = ResponseController.shared.responses[indexPath.row]
        
        cell.response = response
        
        return cell
    }
    
    func sendResponseToBlockAlertController(response: Response) {
        self.response = response
        performSegue(withIdentifier: "toBlockUserAlertVC", sender: self)
    }
}
