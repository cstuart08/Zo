//
//  DailyController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import Foundation
import CloudKit

class DailyController {
    
    // MARK: - Properties
    static let shared = DailyController()
    var myDailyJournals: [DailyJournal] = []
    
    // MARK: - Methods
    
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    func createDailyJournal(imageURL: String, entry: String, userReference: CKRecord.Reference, completion: @escaping (Bool) -> Void) {
        
        let dailyJournal = DailyJournal(imageURL: imageURL, entry: entry, userReference: userReference)
        
        let dailyJournalRecord = CKRecord(dailyJournal: dailyJournal)
        
        publicDataBase.save(dailyJournalRecord) { (dailyJournalRecord, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let dailyJournalRecord = dailyJournalRecord,
                let dailyJournal = DailyJournal(ckRecord: dailyJournalRecord) else { completion(false); return }
            
            self.myDailyJournals.insert(dailyJournal, at: 0)
            completion(true)
            return
        }
    }
    
    func fetchDailyJournals(completion: @escaping (Bool) -> Void) {
        
        guard let reference = UserController.shared.currentUser?.appleUserReference else { completion(false); return }
        
        let predicate = NSPredicate(format: "\(DailyJournalConstants.userReferenceKey) == %@", reference)
        
        let query = CKQuery(recordType: DailyJournalConstants.typeKey, predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            
            let dailyJournals = records.compactMap({DailyJournal(ckRecord: $0)})
            
            self.myDailyJournals = dailyJournals.sorted(by: { $0.timestamp > $1.timestamp })
            completion(true)
            return
        }
    }
    
    func saveUpdatedJournal(dailyJournal: DailyJournal , entry: String, completion: @escaping (Bool) -> Void) {
        
        let modifiedDailyJournal = dailyJournal
        modifiedDailyJournal.entry = entry
        
        let modificationOperation = CKModifyRecordsOperation(recordsToSave: [CKRecord(dailyJournal: modifiedDailyJournal)], recordIDsToDelete: nil)
        modificationOperation.queuePriority = .high
        modificationOperation.savePolicy = .changedKeys
        modificationOperation.qualityOfService = .userInteractive
        modificationOperation.modifyRecordsCompletionBlock = { (_, _, error) in
            if let error = error {
                print("Unable to modify user response array. \n Error: \(error) \n \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        self.publicDataBase.add(modificationOperation)
        completion(true)
    }
    
    func deleteDailyJournal(dailyJournal: DailyJournal, completion: @escaping (Bool) -> Void) {
        
        let dailyRecordID = dailyJournal.recordID
        
        guard let index = self.myDailyJournals.firstIndex(of: dailyJournal) else { completion(false); return }
        
        self.myDailyJournals.remove(at: index)
        
        self.publicDataBase.delete(withRecordID: dailyRecordID) { (recordID, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
