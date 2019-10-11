//
//  ActiveRequestViewController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class ActiveRequestViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    @IBOutlet weak var numberOfResponsesLabel: UILabel!
    @IBOutlet weak var requestBodyLabel: UILabel!
    
    @IBOutlet weak var responsesTableView: UITableView!
    
    // MARK: - Properties
    var request: Request? {
        didSet {
            setupViews()
        }
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        responsesTableView.delegate = self
        responsesTableView.dataSource = self
        fetchResponses()
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    func fetchResponses() {
        guard let request = request else { return }
        
        ResponseController.shared.fetchResponses(request: request) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.responsesTableView.reloadData()
                }
            }
        }
    }
    
    func setupViews() {
        loadViewIfNeeded()
        guard let request = request else { return }
        requestBodyLabel.text = request.body
        requestImageView.image = UIImage(named: "focus")
        numberOfResponsesLabel.text = "\(request.responseCount)"
        
        
    }
    
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
        return ResponseController.shared.responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "responseCell", for: indexPath) as? ResponseTableViewCell else { return UITableViewCell()}
        
        let response = ResponseController.shared.responses[indexPath.row]
        
        cell.response = response
        
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
