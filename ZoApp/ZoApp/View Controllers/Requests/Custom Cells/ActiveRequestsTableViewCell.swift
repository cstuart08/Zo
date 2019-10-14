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
    
    let randomImages: [UIImage] = [UIImage(named: "canyonJump")!]
    
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
        requestImageView.image = randomImages.randomElement()
        numberOfResponsesLabel.text = "\(request.responseCount)"
        guard let tag1 = self.tag1, let tag2 = self.tag2, let tag3 = self.tag3 else { return }
        tagsLabel.text = "\(tag1)   \(tag2)   \(tag3)"
    }
    
    func stylizeSubviews() {
        tagsLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.rawValue)
        tagsLabel.textColor = .blueGrey
        requestBodyLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.rawValue)
        requestBodyLabel.textColor = .blueGrey
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h4.rawValue)
        usernameLabel.textColor = .blueGrey
    }
}
