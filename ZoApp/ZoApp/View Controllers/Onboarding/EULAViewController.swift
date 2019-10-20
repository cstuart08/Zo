//
//  EULAViewController.swift
//  ZoApp
//
//  Created by Apps on 10/20/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class EULAViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var eulaTextView: UITextView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var acceptTermsLabel: UILabel!
    @IBOutlet weak var nextButton: OnBoardingButton!
    
    // MARK: - Properties
    var userAgrees = false
    let eulaText = """
    Zō Aoo - End User License Agreement
    Last updated: October 20th, 2019

    This End User License Agreement (hereby referred to as "Agreement") is designed to govern your use of the Zō App (hereby referred to as "Zō").

    Parties: This Agreement is between you (the user) and Zō only, and not Apple, Inc (hereby refered to as "Apple"). Zō, not Apple, is soley responsible for the the Zō app and any of it's content. Although Apple is not a party in this Agreement, Apple has the right to enforce this Agreement at any point in time.

    License: This Agreement serves as a limited license provided to you, the user, from Zō. This license is non-transferable, non-exclusive and revocable. You are only permitted to us the Zō App on an iPhone, iPod Touch, iPad, or any other Apple device that you own or control, as permitted by the App Store Terms of Service. You are not permitted to use the Zō App for commercial purposes.

    Maintenance & Support: Due to the Zō App being free to download and use, Zō does not provide any maintenance or support. To the extent that any maintenance  or support is required by the law, Zō, not Apple, shall be obligated to provide any such maintenance and/or support.

    Warranty: The Zō App is provided for free on an “as is” basis. As such, Zō disclaims all warranties about the Zō App to the fullest extent permitted by law. To the extent any warranty exists under law that cannot be disclaimed, Zō, not Apple, shall be solely responsible for such warranty.

    Product Claims: You and the End-User must acknowledge that You, not Apple, are responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the end- user’s possession and/or use of that Licensed Application, including, but not limited to: (i) product liability claims; (ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application’s use of the HealthKit and HomeKit frameworks. The Agreement may not limit Your liability to the End-User beyond what is permitted by applicable law.

    Third Party Itellectual Property Claims: To the extent Zō is required to provide indemnification by applicable law, Zō, not Apple, shall be solely responsible for the investigation, defense, settlement and discharge of any claim that the Zō App or your use of it infringes any third party intellectual property right.

    Legal Compliance: You represent and warrant that (i) he/she is not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a “terrorist supporting” country; and (ii) he/she is not listed on any U.S. Government list of prohibited or restricted parties.

    Developer Contact Information: The Zō App is produced by multiple developers reffered to as The Zō Team. For any questions, complaints, or feedback, The Zō team can be reached at:
    561.901.0933
    apps@cameronstuart.com
    4200 N Seasons View Drive
    Unit: L1104
    Lehi, UT 84043, USA

    Zō App Use: You must comply with any applicable third party terms of agreement when using the Zō App. Your right to use the Zō App will terminate immediately if you violate any provisions of this License Agreement. Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the Zō App.

    Third Party Beneficiary: Apple is a third party beneficiary of this Agreement, and, upon your acceptance, Apple will have the right (and will be deemed to have accepted the right) to enforce this agreement against you.

    Objectionable Content: By agreeing with all terms listed in this Agreement, you acknowledge that there is absolutely no tolerence for objectionable content, including, but not limited to: Nudity, Sexual Content, Violence of any variety, or abusive communication. If you are found to produce any objectionable contenet, you will immediately be removed and banned from the Zō App.

    """
    
    // MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func acceptButtonChecked(_ sender: Any) {
        if userAgrees == false {
            nextButton.isEnabled = true
            checkBoxButton.setImage(UIImage(named: "complete"), for: .normal)
            nextButton.setTitleColor(.zoWhite, for: .normal)
            nextButton.layer.borderColor = UIColor.zoWhite.cgColor
            userAgrees = true
        } else if userAgrees == true {
            nextButton.isEnabled = false
            checkBoxButton.setImage(UIImage(named: "incomplete"), for: .normal)
            nextButton.setTitleColor(.blueGrey, for: .normal)
            nextButton.layer.borderColor = UIColor.blueGrey.cgColor
            userAgrees = false
        }
    }
    
    // MARK: - UI Adjustments
    func setupUI() {
        /// Background
        view.backgroundColor = .boldGreen
        /// Header Label
        headerLabel.font = UIFont(name: FontAttributes.h2.fontFamily, size: FontAttributes.h4.fontSize)
        headerLabel.textColor = .zoWhite
        /// EULA Text View
        eulaTextView.addPadding()
        eulaTextView.addCornerRadius(13.0)
        eulaTextView.layer.masksToBounds = true
        eulaTextView.text = eulaText
        /// Check Box Button
        checkBoxButton.setImage(UIImage(named: "incomplete"), for: .normal)
        /// Accept Terms Label
        acceptTermsLabel.font = UIFont(name: FontAttributes.body.fontFamily, size: FontAttributes.body.fontSize)
        acceptTermsLabel.textColor = .zoWhite
        /// Next Button
        nextButton.setTitleColor(.blueGrey, for: .normal)
        nextButton.layer.borderColor = UIColor.blueGrey.cgColor
    }
}
