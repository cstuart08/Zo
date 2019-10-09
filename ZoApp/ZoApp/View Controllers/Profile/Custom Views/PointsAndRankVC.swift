//
//  PointsAndRankVC.swift
//  JustBreateApp
//
//  Created by Blake kvarfordt on 10/8/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
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
