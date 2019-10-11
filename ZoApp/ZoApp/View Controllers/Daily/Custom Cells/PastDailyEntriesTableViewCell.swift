//
//  PastDailyEntriesTableViewCell.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/11/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class PastDailyEntriesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stylizeSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = frame.height / 8
        let width = frame.width / 13
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: height, left: width, bottom: height, right: width))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UI Adjustments
    
    func stylizeSubviews() {
        backgroundColor = .ivory
        contentView.addAccentBorder(width: 3, color: .boldGreen)
        contentView.addCornerRadius()
        contentView.backgroundColor = .zoWhite
        
    }


}
