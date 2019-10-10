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
    
    // MARK: - Properties
    let currentUser = UserController.shared.currentUser
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        descriptionLabel.layer.borderWidth = 5
        
        guard let currentUser = currentUser else { return }
        rankLabel.text = ChakraController.shared.updateChakraImage(user: currentUser).chakraName
        imageView.image = ChakraController.shared.updateChakraImage(user: currentUser).chakraImage
        pointsLabel.text = "\(currentUser.kpPoints) KP"
        descriptionLabel.text = ChakraController.shared.updateChakraImage(user: currentUser).chakraLevelDescription
    }
}
