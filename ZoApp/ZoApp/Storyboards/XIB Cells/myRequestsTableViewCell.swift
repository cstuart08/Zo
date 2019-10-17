//
//  myRequestsTableViewCell.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/15/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class myRequestsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var requestTagsLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
        
        requestBodyLabel.text = request.body
        requestImageView.image = request.image
        numberOfResponsesLabel.text = "\(request.responseCount)"
        requestTagsLabel.text = "\(tag1)   \(tag2)   \(tag3)"
    }
    
    func stylizeSubviews() {
        backgroundColor = .clear
        
        requestTagsLabel.addAccentBorder(width: 2, color: .boldGreen)
        requestTagsLabel.addCornerRadius()
        requestTagsLabel.layer.masksToBounds = true
        requestTagsLabel.textColor = .blueGrey
        requestTagsLabel.backgroundColor = .zoWhite
        requestTagsLabel.font = UIFont(name: FontAttributes.caption.fontFamily, size: FontAttributes.caption.fontSize)
        
        requestBodyLabel.addAccentBorder(width: 2, color: .boldGreen)
        requestBodyLabel.addCornerRadius()
        requestBodyLabel.layer.masksToBounds = true
        requestBodyLabel.font = UIFont(name: FontAttributes.h4.fontFamily, size: FontAttributes.h4.fontSize)
        requestBodyLabel.textColor = .blueGrey
        requestBodyLabel.backgroundColor = .zoWhite
        
        numberOfResponsesLabel.addAccentBorder(width: 2, color: .darkBlue)
        numberOfResponsesLabel.addCornerRadius(6)
        numberOfResponsesLabel.layer.masksToBounds = true
        numberOfResponsesLabel.textColor = .zoWhite
        numberOfResponsesLabel.font = UIFont(name: FontAttributes.number.fontFamily, size: FontAttributes.number.fontSize)
        numberOfResponsesLabel.backgroundColor = .darkBlue
        
        requestImageView.addCornerRadius()
    }

    
}
