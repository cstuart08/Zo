//
//  Request.swift
//  JustBreateApp
//
//  Created by Blake kvarfordt on 10/4/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation
import CloudKit

struct RequestConstants {
   static let usernameKey = "Username"
    static let titleKey = "Title"
    static let bodyKey = "Body"
    static let tagsKey = "Tags"
    static let timestampKey = "Timestamp"
    static let responseCountKey = "ResponseCount"
    static let recordTypeKey = "Request"
    static let userReferenceKey = "UserReference"
}

class Request {
    let username: String
    let title: String
    let body: String
    var tags: [String] = []
    let timestamp: Double
    var responseCount: Int = 0
    let recordID: CKRecord.ID
    let userReference: CKRecord.Reference
       
    init(username: String, title: String, body: String, timestamp: Double = Date().timeIntervalSince1970, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), userReference: CKRecord.Reference) {
           
        self.username = username
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
        self.userReference = userReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[RequestConstants.usernameKey] as? String,
            let title = ckRecord[RequestConstants.titleKey] as? String,
            let body = ckRecord[RequestConstants.bodyKey] as? String,
            let timestamp = ckRecord[RequestConstants.timestampKey] as? Double,
            let responseCount = ckRecord[RequestConstants.responseCountKey] as? Int,
            let userReference = ckRecord[RequestConstants.userReferenceKey] as? CKRecord.Reference else { return nil }
        
        self.username = username
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.responseCount = responseCount
        self.userReference = userReference
        self.recordID = ckRecord.recordID
        if let tags = ckRecord[RequestConstants.tagsKey] as? [String] {
            self.tags = tags
        }
    }
}

extension CKRecord {
    convenience init(request: Request) {
        self.init(recordType: RequestConstants.recordTypeKey, recordID: request.recordID)
        self.setValue(request.username, forKey: RequestConstants.usernameKey)
        self.setValue(request.body, forKey: RequestConstants.bodyKey)
        self.setValue(request.title, forKey: RequestConstants.titleKey)
        self.setValue(request.timestamp, forKey: RequestConstants.timestampKey)
        self.setValue(request.responseCount, forKey: RequestConstants.responseCountKey)
        self.setValue(request.userReference, forKey: RequestConstants.userReferenceKey)
        
        if !request.tags.isEmpty {
            self.setValue(request.tags, forKey: RequestConstants.tagsKey)
        }
    }
}
