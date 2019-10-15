//
//  ProfileViewCell.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var requestTextLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    

    
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    
    func setupViews() {
        guard let responseCount = request?.responseCount else { return }
        requestTextLabel.text = request?.body
        requestImageView.image = UIImage(named: "focus")
        numberOfResponsesLabel.text = "\(responseCount)"
        requestImageView.addCornerRadius()
        numberOfResponsesLabel.layer.masksToBounds = true
        numberOfResponsesLabel.addCornerRadius(6)
        usernameLabel.layer.masksToBounds = true
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        usernameLabel.textColor = .blueGrey
        usernameLabel.backgroundColor = .zoWhite
        usernameLabel.addCornerRadius()
        usernameLabel.addAccentBorder(width: 3, color: .boldGreen)
        requestTextLabel.layer.masksToBounds = true
        requestTextLabel.backgroundColor = .zoWhite
        requestTextLabel.addCornerRadius()
        requestTextLabel.addAccentBorder(width: 3, color: .boldGreen)
    }
}
