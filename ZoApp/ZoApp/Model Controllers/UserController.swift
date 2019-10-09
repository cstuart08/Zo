//
//  UserController.swift
//  JustBreateApp
//
//  Created by Apps on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
        
    static let shared = UserController()
    
    var currentUser: User?
    var userReference: CKRecord.Reference?
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func createUser(username: String, completion: @escaping (Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (userID, error) in
            if let error = error {
                print("Failed to fetch the users appleID! \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let userID = userID else { completion(false); return }
            
            let reference = CKRecord.Reference(recordID: userID, action: .deleteSelf)
            self.userReference = reference
            let newUser = User(username: username, appleUserReference: reference)
            let userRecord = CKRecord(user: newUser)
            
            self.publicDB.save(userRecord) { (record, error) in
                if let error = error {
                    print("Failed to create a new user! \n Error: \(error) \n \(error.localizedDescription)")
                    completion(false)
                    return
                }
                if let record = record {
                    let savedUser = User(ckRecord: record)
                    self.currentUser = savedUser
                    completion(true)
                }
            }
        }
    }
    
    func fetchUserReference(completion: @escaping (Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (record, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let record = record {
                let reference = CKRecord.Reference(recordID: record, action: .deleteSelf)
                self.userReference = reference
                print("Got user ref")
                completion(true)
            }
        }
    }
    
    func fetchUser(completion: @escaping (Bool) -> Void) {
        
        guard let reference = userReference else { completion(false); return }
        let predicate = NSPredicate(format: "\(UserConstants.appleUserReferenceKey) == %@", reference)
        let query = CKQuery(recordType: UserConstants.typeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (userRecord, error) in
            if let error = error {
                print("Don't got user.")
                print("Failed to fetch user! \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let userRecord = userRecord {
                if userRecord.count > 0 {
                    let foundUser = User(ckRecord: userRecord[0])
                    self.currentUser = foundUser
                    print("Got User")
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    // Updates the users array of responses in order to precent that response from showing up for them again.
    func updateUserResponseList(user: User, responseRecordID: String, completion: @escaping (Bool) -> Void) {
        
        let modifiedUser = user
        modifiedUser.respondedTo.append(responseRecordID)
        
        let modificationOP = CKModifyRecordsOperation(recordsToSave: [CKRecord(user: user)], recordIDsToDelete: nil)
        modificationOP.savePolicy = .changedKeys
        modificationOP.qualityOfService = .userInteractive
        modificationOP.queuePriority = .high
        modificationOP.modifyRecordsCompletionBlock = { (_, _, error) in
            if let error = error {
                print("Unable to modify user response array. \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
        
        self.publicDB.add(modificationOP)
        currentUser = modifiedUser
    }
}
