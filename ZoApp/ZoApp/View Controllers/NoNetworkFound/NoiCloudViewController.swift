//
//  NoiCloudViewController.swift
//  ZoApp
//
//  Created by Kevin Tanner on 10/21/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class NoiCloudViewController: UIViewController {

    @IBOutlet weak var noiCloudAccountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .boldGreen
        noiCloudAccountLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        noiCloudAccountLabel.textColor = .zoWhite
        noiCloudAccountLabel.text = " Uh-oh! It looks like you are not signed in to your iCloud account! \n \n Please sign in to your iCloud account and re-launch the app."
    }
    

    

}
