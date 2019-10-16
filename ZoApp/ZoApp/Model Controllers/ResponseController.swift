//
//  ResponseController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
import CloudKit

class ResponseController {
    
    static let shared = ResponseController()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var responses = [Response]()
    
    func createResponse(username: String, bodyText: String?, link: String?, image: UIImage?, responseTags: [String], requestReference: CKRecord.Reference, completion: @escaping (Bool) -> Void) {
        
        let responseRecord = Response(username: username, bodyText: bodyText, image: image, link: link, responseTags: responseTags, requestReference: requestReference)
        
        let realRecord = CKRecord(response: responseRecord)
        
        self.publicDB.save(realRecord) { (_, error) in
            if let error = error {
                print("Failed to create a new response! \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
            
            self.responses.append(responseRecord)
            completion(true)
        }
    }
    
    func fetchResponses(request: Request, completion: @escaping (Bool) -> Void) {
        responses = []
        let requestReference = request.recordID
        let predicate = NSPredicate(format: "\(ResponseConstants.requestReferenceKey) == %@", requestReference)
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
    
    func deleteResponse(response: Response, completion: @escaping (Bool) -> Void) {
        let responseRecord = response.responseRecordID
        
        guard let firstIndex = self.responses.firstIndex(of: response) else { completion(false); return }
        
        responses.remove(at: firstIndex)
        
        publicDB.delete(withRecordID: responseRecord) { (recordID, error) in
            if let error = error {
                print("Error deleting response", error.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
}
