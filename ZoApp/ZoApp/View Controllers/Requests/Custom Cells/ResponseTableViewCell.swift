//
//  ResponseTableViewCell.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var responseImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var responseBodyLabel: UILabel!
    @IBOutlet weak var favoriteResponseButton: UIButton!
    @IBOutlet weak var flagResponseButton: UIButton!
    @IBOutlet weak var blockUserButton: UIButton!
    @IBOutlet weak var bookmarkResponseButton: UIButton!
    
    // MARK: - Properties
    
    var requestLandingPad: ProfileMockDataModel3? {
        didSet {
            layoutIfNeeded()
            setupView()
        }
    }

    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteResponseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func flagResponseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func blockUserButtonTapped(_ sender: Any) {
    }
    
    @IBAction func bookmarkResponseButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments
    func setupView() {
        responseImageView.image = requestLandingPad?.image
        usernameLabel.text = "UserNAME"
        responseBodyLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
}
