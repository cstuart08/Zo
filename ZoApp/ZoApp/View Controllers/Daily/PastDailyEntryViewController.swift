//
//  PastDailyEntryViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class PastDailyEntryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pastDailyEntryImageView: UIImageView!
    @IBOutlet weak var pastDailyEntryTextView: UITextView!
    
    // MARK - Properties
    ///Mock Data
    let randomImages: [UIImage] = [#imageLiteral(resourceName: "mountain"), #imageLiteral(resourceName: "canyonJump"), #imageLiteral(resourceName: "difficultRoads"), #imageLiteral(resourceName: "focus")]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pastDailyEntryImageView.image = randomImages.randomElement()
    }
    
    // Hello
    
    // MARK: - Methods
    @objc func tapResign() {
        pastDailyEntryTextView.resignFirstResponder()
    }
}
