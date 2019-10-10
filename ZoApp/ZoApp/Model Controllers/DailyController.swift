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
            
            self.myDailyJournals.append(dailyJournal)
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
            
            self.myDailyJournals = dailyJournals
            completion(true)
            return
        }
    }
    
    
    
    
    
    
    
    
}
