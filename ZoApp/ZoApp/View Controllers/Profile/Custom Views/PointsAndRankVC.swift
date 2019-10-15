//
//  PointsAndRankVC.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class PointsAndRankVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    // MARK: - Properties
    let currentUser = UserController.shared.currentUser
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        descriptionView.addAccentBorder(width: 5, color: .blueGrey)
        descriptionView.addCornerRadius()
        descriptionLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        descriptionLabel.textColor = .blueGrey
        pointsLabel.font = UIFont(name: FontAttributes.h1.fontFamily, size: FontAttributes.h1.fontSize)
        popupView.addCornerRadius()
        
        
        
        guard let currentUser = currentUser else { return }
        rankLabel.text = "YOU ARE ON THE \(ChakraController.shared.updateChakraImage(user: currentUser).chakraName) CHAKRA"
        rankLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        imageView.image = ChakraController.shared.updateChakraImage(user: currentUser).chakraImage
        imageView.addCornerRadius()
        imageView.backgroundColor = .zoWhite
        pointsLabel.text = "\(currentUser.kpPoints) KP"
        descriptionLabel.text = ChakraController.shared.updateChakraImage(user: currentUser).chakraLevelDescription
    }
}
