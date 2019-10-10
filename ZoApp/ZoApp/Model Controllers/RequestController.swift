//
//  RequestController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import Foundation
import CloudKit

class RequestController {
    
    static let shared = RequestController()
    
    var requests: [Request] = []
    var myRequests: [Request] = []
    
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    func createAndSaveRequest(title: String, username: String, body: String, userReference: CKRecord.Reference, completion: @escaping (Bool) -> Void) {
        let request = Request(username: username, title: title, body: body, userReference: userReference)
        
        let requestRecord = CKRecord(request: request)
        
        publicDataBase.save(requestRecord) { (record, error) in
            
            if let error = error {
                print("Error saving a record to database in AHHH \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let record = record, let request = Request(ckRecord: record) else { completion(false); return }
            
            self.requests.append(request)
        }
        
        completion(true)
        return
    }
    
    func fetchRequests(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RequestConstants.recordTypeKey, predicate: predicate)
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error fetching requests from database in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            
            
            let requests = records.compactMap({Request(ckRecord: $0)})
            
            var filteredRequests: [Request] = []
            
            for request in requests {
                guard let user = UserController.shared.currentUser else { completion(false); return }
                if !user.respondedTo.contains(request.recordID.recordName) {
                    filteredRequests.append(request)
                }
            }
            
            self.requests = filteredRequests
            completion(true)
        }
    }
    
    func fetchCurrentUserRequests(completion: @escaping (Bool) -> Void) {
        guard let userReference  = UserController.shared.currentUser?.recordID else { completion(false); return }
        
        let predicate = NSPredicate(format: "\(RequestConstants.userReferenceKey)", userReference)
        let query = CKQuery(recordType: RequestConstants.recordTypeKey, predicate: predicate)
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error fetching requests from database in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            let requests = records.compactMap({Request(ckRecord: $0)})
            
            self.requests = requests
            completion(true)
            
        }
    }
}
