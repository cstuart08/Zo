//
//  ActiveRequestsTableViewCell.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class ActiveRequestsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    // MARK: - Properties
    var requestLandingPad: Request? {
        didSet {
            layoutIfNeeded()
            setupView()
            stylizeSubviews()
        }
    }
    var tag1: String?
    var tag2: String?
    var tag3: String?
    
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments
    func setupView() {
        guard let request = requestLandingPad else { return }
        
        
        if request.tags[2] == "#" {
            tag3 = ""
        } else {
            tag3 = request.tags[2]
        }
        
        if request.tags[1] == "#" {
            tag2 = ""
        } else {
            tag2 = request.tags[1]
        }
        
        if request.tags[0] == "#" {
            tag1 = ""
        } else {
            tag1 = request.tags[0]
        }
        
        usernameLabel.text = request.username
        requestBodyLabel.text = request.body
        requestImageView.image = request.image
        numberOfResponsesLabel.text = "\(request.responseCount)"
        guard let tag1 = self.tag1, let tag2 = self.tag2, let tag3 = self.tag3 else { return }
        tagsLabel.text = "\(tag1)   \(tag2)   \(tag3)"
    }
    
    func stylizeSubviews() {
        tagsLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        tagsLabel.addCornerRadius(13)
        tagsLabel.layer.masksToBounds = true
        requestBodyLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        requestBodyLabel.addCornerRadius(13)
        requestBodyLabel.layer.masksToBounds = true
        usernameLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        usernameLabel.addCornerRadius(13)
        usernameLabel.layer.masksToBounds = true
        tagsLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        tagsLabel.textColor = .blueGrey
        requestBodyLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        requestBodyLabel.textColor = .blueGrey
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h4.fontSize)
        usernameLabel.textColor = .blueGrey
        requestImageView.addCornerRadius()
        numberOfResponsesLabel.layer.masksToBounds = true
        numberOfResponsesLabel.backgroundColor = .darkBlue
        numberOfResponsesLabel.addCornerRadius(6)
        numberOfResponsesLabel.font = UIFont(name: FontAttributes.number.fontFamily, size: FontAttributes.number.fontSize)
    }
}
