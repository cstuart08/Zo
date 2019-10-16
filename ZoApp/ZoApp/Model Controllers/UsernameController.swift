//
//  UsernameController.swift
//  ZoApp
//
//  Created by Apps on 10/16/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CloudKit

class UsernameController {
    
    static let shared = UsernameController()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var usernames: [String] = []
    
    func fetchAllUsernames(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: UserConstants.typeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let records = records {
                for record in records {
                    guard let user = User(ckRecord: record) else { completion(false); return }
                    self.usernames.append(user.username.lowercased())
                }
                completion(true)
            }
        }
    }
}
