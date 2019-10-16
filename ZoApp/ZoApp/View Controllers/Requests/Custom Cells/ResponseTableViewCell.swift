//
//  ResponseTableViewCell.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

protocol responseTVCellDelegate: class {
    func sendResponseToBlockAlertController(response: Response)
}

class ResponseTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var responseImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var responseBodyLabel: UILabel!
    @IBOutlet weak var favoriteResponseButton: UIButton!
    @IBOutlet weak var flagResponseButton: UIButton!
    @IBOutlet weak var blockUserButton: UIButton!
    @IBOutlet weak var bookmarkResponseButton: UIButton!
    @IBOutlet weak var urlTextView: UITextView!
    
    // MARK: - Properties
    
    weak var delegate: responseTVCellDelegate?
    
    var response: Response? {
        didSet {
            setupView()
            layoutIfNeeded()
        }
    }

    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkResponseButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteResponseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func flagResponseButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("showMailComposer"), object: nil)
    }
    
    @IBAction func blockUserButtonTapped(_ sender: Any) {
        guard let response = response else { return }
        self.delegate?.sendResponseToBlockAlertController(response: response)
    }
    
    @IBAction func bookmarkResponseButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments
    func setupView() {
        guard let response = response else { return }
        if let image = response.image {
            responseImageView.isHidden = false
            responseImageView.image = image
        } else {
            responseImageView.isHidden = true
        }
        if response.link == "" {
            urlTextView.isHidden = true
        } else {
            urlTextView.isHidden = false
        }
        // MARK: - Username Label
        usernameLabel.text = response.username
        usernameLabel.backgroundColor = .zoWhite
        usernameLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        usernameLabel.textColor = .blueGrey
        usernameLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        usernameLabel.addCornerRadius(8.0)
        usernameLabel.layer.masksToBounds = true
        // MARK: - Response Body Label
        responseBodyLabel.text = response.bodyText
        responseBodyLabel.backgroundColor = .zoWhite
        responseBodyLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        responseBodyLabel.textColor = .blueGrey
        responseBodyLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        responseBodyLabel.addCornerRadius(8.0)
        responseBodyLabel.layer.masksToBounds = true
        // MARK: - URL TextView
        urlTextView.text = response.link
        urlTextView.textColor = .blueGrey
        urlTextView.addAccentBorder(width: 2.0, color: .boldGreen)
        urlTextView.addCornerRadius(8.0)
    }
}
