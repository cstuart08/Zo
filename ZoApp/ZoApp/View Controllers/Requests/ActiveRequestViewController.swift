//
//  ActiveRequestViewController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ActiveRequestViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    
    @IBOutlet weak var responsesTableView: UITableView!
    
    // MARK: - Properties
    var request: Request?
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        responsesTableView.delegate = self
        responsesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ActiveRequestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "responseCell", for: indexPath) as? ResponseTableViewCell else { return UITableViewCell()}
        
        let request = ProfileMockDataController3.shared.mockDataObjects[indexPath.row]
        
        cell.requestLandingPad = request
        
        return cell
    }
    
    
}


class ProfileMockDataModel3 {
    let text: String
    let image: UIImage?
    
    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
}

class ProfileMockDataController3 {
    static let shared = ProfileMockDataController3()
    
    var mockDataObjects = [ProfileMockDataModel3]()
    
    init() {
        
        let request1 = ProfileMockDataModel3(text: "#whatever #amiseeingthings #iphoneForTheWin", image: UIImage(named: "mountain"))
        let request2 = ProfileMockDataModel3(text: "#customTableViews #BadDay #WorkSucks", image: UIImage(named: "focus"))
        let request3 = ProfileMockDataModel3(text: "#DoesItWork #WAterIsLife #RAinbow", image: UIImage(named: "canyonJump"))
        
        self.mockDataObjects = [request1, request2, request3]
    }
}
