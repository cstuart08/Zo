//
//  FavoriteResponseAlertViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class FavoriteResponseAlertViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var goodAnswerTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fireAndPointsView: UIView!
    @IBOutlet weak var fireImageView: UIImageView!
    @IBOutlet weak var kpLabel: UILabel!
    
    // MARK: - Properties
    var responseLandingPad: Response?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeSubviews()
        // Do any additional setup after loading the view.
        
    }
    
    
    // MARK: - Adjust UI
    func stylizeSubviews() {
        alertView.backgroundColor = .boldGreen
        alertView.addCornerRadius()
        fireAndPointsView.backgroundColor = .zoWhite
        fireAndPointsView.addCornerRadius()
        goodAnswerTitleLabel.font = UIFont(name: FontAttributes.h1.fontFamily, size: FontAttributes.h1.fontSize)
        goodAnswerTitleLabel.textColor = .zoWhite
        usernameLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        usernameLabel.textColor = .zoWhite
        kpLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        kpLabel.textColor = .blueGrey
        guard let response = responseLandingPad else { return }
        usernameLabel.text = response.username
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
