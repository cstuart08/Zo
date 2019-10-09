//
//  PastDailyEntryViewController.swift
//  JustBreateApp
//
//  Created by Apps on 10/7/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
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
