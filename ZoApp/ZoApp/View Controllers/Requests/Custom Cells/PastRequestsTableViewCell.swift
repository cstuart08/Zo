//
//  PastRequestsTableViewCell.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class PastRequestsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImage: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    
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
        requestBodyLabel.bounds.inset(by: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
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
            self.tag3 = ""
        } else {
            self.tag3 = request.tags[2]
        }
        
        if request.tags[1] == "#" {
            self.tag2 = ""
        } else {
            self.tag2 = request.tags[1]
        }
        
        if request.tags[0] == "#" {
            self.tag1 = ""
        } else {
            self.tag1 = request.tags[0]
        }
        
        guard let tag1 = self.tag1, let tag2 = self.tag2, let tag3 = self.tag3 else { return }
        
        requestBodyLabel.text = requestLandingPad?.body
        requestImage.image = request.image
        numberOfResponsesLabel.text = "\(request.responseCount)"
        tagsLabel.text = "\(tag1)   \(tag2)   \(tag3)"
    }
    
    func stylizeSubviews() {
        tagsLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        tagsLabel.addCornerRadius(13)
        tagsLabel.layer.masksToBounds = true
        requestBodyLabel.addAccentBorder(width: 2.0, color: .boldGreen)
        requestBodyLabel.addCornerRadius(13)
        requestBodyLabel.layer.masksToBounds = true
        tagsLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        tagsLabel.textColor = .blueGrey
        requestBodyLabel.font = UIFont(name: FontAttributes.h3.fontFamily, size: FontAttributes.h4.fontSize)
        requestBodyLabel.textColor = .blueGrey
    }
}
