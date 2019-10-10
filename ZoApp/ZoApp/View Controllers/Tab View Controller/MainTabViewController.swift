//
//  MainTabViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeSubviews()
        // Do any additional setup after loading the view.
    }
    
    
    func stylizeSubviews() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.boldGreen
        tabBar.tintColor = UIColor.zoWhite
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
