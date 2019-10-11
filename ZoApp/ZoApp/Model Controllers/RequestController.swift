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
    
    func createAndSaveRequest(title: String, username: String, body: String, userReference: CKRecord.Reference, tags: [String], completion: @escaping (Bool) -> Void) {
        let request = Request(username: username, title: title, body: body, userReference: userReference, tags: tags)
        
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
                if request.userReference.recordID.recordName != user.recordID.recordName {
                    filteredRequests.append(request)
                }
            }

            self.requests = filteredRequests
            completion(true)
        }
    }
    
    func fetchAllCurrentUserRequests(completion: @escaping (Bool) -> Void) {
        myRequests = []
        guard let userReference = UserController.shared.currentUser?.recordID else { completion(false); return }
        let predicate = NSPredicate(format: "\(RequestConstants.userReferenceKey) == %@", userReference)
        let query = CKQuery(recordType: RequestConstants.recordTypeKey, predicate: predicate)
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error fetching requests from database in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            print("got some records")
            let requests = records.compactMap({Request(ckRecord: $0)})
            print("got requests from records")
            
            self.myRequests = requests
            completion(true)
            print("completion true")
        }
    }
    
    func fetchOnlyRecentCurrentUserRequests(completion: @escaping (Bool) -> Void) {
        let date = NSDate(timeInterval: -60.0 * 60 * 72, since: Date())
        guard let user = UserController.shared.currentUser else { completion(false); return }
        let predicate = NSPredicate(format: "creationDate > %@", date)
        let predicate2 = NSPredicate(format: "\(RequestConstants.userReferenceKey) == %@", user.recordID)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        let query = CKQuery(recordType: RequestConstants.recordTypeKey, predicate: compoundPredicate)
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching requests from database in \(#function) \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else { completion(false); return }
            let requests = records.compactMap({Request(ckRecord: $0)})
            
            self.myRequests = requests
            completion(true)
        }
    }
    
    func modifyRecordsOperation(request: Request, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [CKRecord(request: request)]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        publicDataBase.add(operation)
    }
}
