//
//  ResponseTableViewCell.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
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
    
    var response: Response? {
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
        guard let response = response else { return }
        if let image = response.image {
            responseImageView.image = image
        } else {
            responseImageView.isHidden = true
        }
        usernameLabel.text = response.username
        usernameLabel.backgroundColor = .zoWhite
        
        responseBodyLabel.text = response.bodyText
    }
}
