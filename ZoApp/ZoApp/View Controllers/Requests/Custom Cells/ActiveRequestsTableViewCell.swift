//
//  ActiveRequestsTableViewCell.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ActiveRequestsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    
    // MARK: - Properties
    var requestLandingPad: Request? {
        didSet {
            layoutIfNeeded()
            setupView()
        }
    }
    let randomImages: [UIImage] = [UIImage(named: "canyonJump")!]

    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments
    func setupView() {
        guard let request = requestLandingPad else { return }
        usernameLabel.text = request.username
        requestBodyLabel.text = request.body
        requestImageView.image = randomImages.randomElement()
        numberOfResponsesLabel.text = "\(request.responseCount)"
    }
}
