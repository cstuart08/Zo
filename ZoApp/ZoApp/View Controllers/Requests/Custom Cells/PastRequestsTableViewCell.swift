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
        }
    }
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        tagsLabel.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments

    func setupView() {
        requestBodyLabel.text = requestLandingPad?.body
        tagsLabel.text = "tag"
        requestImage.image = UIImage(named: "focus")
        numberOfResponsesLabel.text = "3"
    }
}
