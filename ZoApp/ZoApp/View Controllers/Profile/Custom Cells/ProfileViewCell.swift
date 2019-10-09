//
//  ProfileViewCell.swift
//  JustBreateApp
//
//  Created by Blake kvarfordt on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var requestTextLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    

    
    var request: ProfileMockDataModel? {
        didSet {
            setupViews()
        }
    }
    
    func setupViews() {
        requestTextLabel.text = request?.text
        requestImageView.image = request?.image
        numberOfResponsesLabel.text = "\(22)"
    }
}
