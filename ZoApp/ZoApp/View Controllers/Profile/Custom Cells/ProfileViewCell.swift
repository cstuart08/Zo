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
    
    // MARK: - Properties
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    var randomImages: [UIImage] = [UIImage(named: "quote1")!, UIImage(named: "quote2")!, UIImage(named: "quote3")!, UIImage(named: "quote4")!, UIImage(named: "quote5")!, UIImage(named: "quote6")!, UIImage(named: "quote7")!, UIImage(named: "quote8")!, UIImage(named: "quote9")!, UIImage(named: "quote10")!, UIImage(named: "quote11")!, UIImage(named: "quote12")!, UIImage(named: "quote13")!]
    
    func setupViews() {
        guard let responseCount = request?.responseCount else { return }
        requestTextLabel.text = request?.body
        requestImageView.image = request?.image
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
