//
//  User.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import Foundation
import CloudKit

struct UserConstants {
    static let typeKey = "User"
    static let usernameKey = "usernameKey"
    static let kpPointsKey = "kpPointsKey"
    static let kpLevelKey = "kpLevelKey"
    static let respondedToKey = "respondedToKey"
    static let savedResponsesKey = "savedResponsesKey"
    static let appleUserReferenceKey = "appleUserReferenceKey"
    static let isBlockedKey = "isBlocked"
    static let lastKarmaLevelIndexKey = "LastKarmaLevelIndexKey"
}

class User {
    
    // MARK: - Properties
    var username: String
    var kpPoints: Int = 0
    var kpLevel: String = "Root"
    var respondedTo: [String] = ["default"]
    var savedResponses: [String] = ["default"]
    var isBlocked = [String]()
    var lastKarmaLevelIndex: Int = 0
    let recordID: CKRecord.ID
    let appleUserReference: CKRecord.Reference
    
    // MARK: - Initializers
    init(username: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference) {
        self.username = username
        self.recordID = recordID
        self.appleUserReference = appleUserReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[UserConstants.usernameKey] as? String,
            let kpPoints = ckRecord[UserConstants.kpPointsKey] as? Int,
            let kpLevel = ckRecord[UserConstants.kpLevelKey] as? String,
            let respondedTo = ckRecord[UserConstants.respondedToKey] as? [String],
            let savedResponses = ckRecord[UserConstants.savedResponsesKey] as? [String],
            let lastKarmaLevelIndex = ckRecord[UserConstants.lastKarmaLevelIndexKey] as? Int,
            let isBlocked = ckRecord[UserConstants.isBlockedKey] as? [String],
            let appleUserReference = ckRecord[UserConstants.appleUserReferenceKey] as? CKRecord.Reference else { return nil }
        
        self.username = username
        self.kpPoints = kpPoints
        self.kpLevel = kpLevel
        self.respondedTo = respondedTo
        self.savedResponses = savedResponses
        self.recordID = ckRecord.recordID
        self.appleUserReference = appleUserReference
        self.isBlocked = isBlocked
        self.lastKarmaLevelIndex = lastKarmaLevelIndex
    }
}

// MARK: - Extensions
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
}

extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserConstants.typeKey, recordID: user.recordID)
        setValue(user.username, forKey: UserConstants.usernameKey)
        setValue(user.kpPoints, forKey: UserConstants.kpPointsKey)
        setValue(user.kpLevel, forKey: UserConstants.kpLevelKey)
        setValue(user.respondedTo, forKey: UserConstants.respondedToKey)
        setValue(user.savedResponses, forKey: UserConstants.savedResponsesKey)
        setValue(user.isBlocked, forKey: UserConstants.isBlockedKey)
        setValue(user.lastKarmaLevelIndex, forKey: UserConstants.lastKarmaLevelIndexKey)
        setValue(user.appleUserReference, forKey: UserConstants.appleUserReferenceKey)
    }
}
