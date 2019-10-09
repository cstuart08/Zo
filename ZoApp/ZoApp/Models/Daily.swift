//
//  Daily.swift
//  JustBreateApp
//
//  Created by Apps on 10/2/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CloudKit

struct DailyJournalConstants {
    static let typeKey = "Daily"
    static let imageURLKey = "imageURLKey"
    static let entryKey = "entryKey"
    static let timestampKey = "timestampKey"
    static let userReferenceKey = "userReferenceKey"
    
}

class DailyJournal {
    
    // MARK: - Properties
    let imageURL: URL
    let entry: String
    let timestamp: Double
    let recordID: CKRecord.ID
    let userReference: CKRecord.Reference
    
    // MARK: - Initializers
    init(imageURL: URL, entry: String, timestamp: Double = Date().timeIntervalSince1970, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), userReference: CKRecord.Reference) {
        self.imageURL = imageURL
        self.entry = entry
        self.timestamp = timestamp
        self.recordID = recordID
        self.userReference = userReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let imageURL = ckRecord[DailyJournalConstants.imageURLKey] as? URL,
            let entry = ckRecord[DailyJournalConstants.entryKey] as? String,
            let timestamp = ckRecord[DailyJournalConstants.timestampKey] as? Double,
            let userReference = ckRecord[DailyJournalConstants.userReferenceKey] as? CKRecord.Reference else { return nil }
        
        self.imageURL = imageURL
        self.entry = entry
        self.timestamp = timestamp
        self.recordID = ckRecord.recordID
        self.userReference = userReference
    }
}

// MARK: - Extensions
extension CKRecord {
    convenience init(dailyJournal: DailyJournal) {
        self.init(recordType: DailyJournalConstants.typeKey, recordID: dailyJournal.recordID)
        setValue(dailyJournal.imageURL, forKey: DailyJournalConstants.imageURLKey)
        setValue(dailyJournal.entry, forKey: DailyJournalConstants.entryKey)
        setValue(dailyJournal.timestamp, forKey: DailyJournalConstants.timestampKey)
        setValue(dailyJournal.userReference, forKey: DailyJournalConstants.userReferenceKey)
    }
}
