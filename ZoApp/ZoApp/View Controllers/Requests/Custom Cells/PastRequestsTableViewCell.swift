//
//  PastRequestsTableViewCell.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class PastRequestsTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImage: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    
    // MARK: - Properties
    var requestLandingPad: ProfileMockDataModel1? {
        didSet {
            layoutIfNeeded()
            setupView()
        }
    }
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments

    func setupView() {
        requestBodyLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        tagsLabel.text = requestLandingPad?.text
        requestImage.image = requestLandingPad?.image
        numberOfResponsesLabel.text = "3"
    }
}
