//
//  ResponseController.swift
//  JustBreateApp
//
//  Created by Apps on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
import CloudKit

class ResponseController {
    
    static let shared = ResponseController()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var responses = [Response]()
    
    func createResponse(username: String, bodyText: String?, link: URL?, image: UIImage?, responseTags: [String], requestReference: CKRecord.Reference, completion: @escaping (Bool) -> Void) {
        
        let responseRecord = Response(username: username, bodyText: bodyText, image: image, link: link, responseTags: responseTags, requestReference: requestReference)
        
        let realRecord = CKRecord(response: responseRecord)
        
        self.publicDB.save(realRecord) { (record, error) in
            if let error = error {
                print("Failed to create a new response! \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchResponses(requestReference: CKRecord.Reference, completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(format: "\(ResponseConstants.responseKey) == %@", requestReference)
        let query = CKQuery(recordType: ResponseConstants.responseKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error fetching responses to a request", error.localizedDescription)
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            let responses = records.compactMap({Response(ckRecord: $0)})
            self.responses = responses
            completion(true)
        }
    }
}
