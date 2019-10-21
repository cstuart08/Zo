//
//  NoNetworkFoundViewController.swift
//  ZoApp
//
//  Created by Apps on 10/21/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class NoNetworkFoundViewController: UIViewController {
    
    @IBOutlet weak var noNetworkFoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .boldGreen
        noNetworkFoundLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h2.fontSize)
        noNetworkFoundLabel.textColor = .zoWhite
        noNetworkFoundLabel.text = " Uh-oh! It looks like you are not connected to the internet! \n \n Please connect to the internet and re-launch the app."
    }
}
