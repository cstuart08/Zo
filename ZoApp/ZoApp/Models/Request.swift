//
//  Request.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit
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
    static let isBlockedKey = "isBlocked"
    static let imageKey = "Image"
}

class Request {
    let username: String
    let title: String
    let body: String
    var tags: [String]
    let timestamp: Double
    var responseCount: Int = 0
    let recordID: CKRecord.ID
    let userReference: CKRecord.Reference
    var imageData: Data?
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        } set {
            imageData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var imageAsset: CKAsset? {
        let tempDict = NSTemporaryDirectory()
        let tempDictURL = URL(fileURLWithPath: tempDict)
        let fileURL = tempDictURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        do {
            try imageData?.write(to: fileURL)
        } catch {
            print("Error writing to temp URL \(error) \(error.localizedDescription)")
        }
        return CKAsset(fileURL: fileURL)
    }
       
    init(username: String, title: String, body: String, timestamp: Double = Date().timeIntervalSince1970, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), userReference: CKRecord.Reference, tags: [String], image: UIImage) {
           
        self.username = username
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
        self.userReference = userReference
        self.tags = tags
        self.image = image
    }
    
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[RequestConstants.usernameKey] as? String,
            let title = ckRecord[RequestConstants.titleKey] as? String,
            let body = ckRecord[RequestConstants.bodyKey] as? String,
            let timestamp = ckRecord[RequestConstants.timestampKey] as? Double,
            let responseCount = ckRecord[RequestConstants.responseCountKey] as? Int,
            let userReference = ckRecord[RequestConstants.userReferenceKey] as? CKRecord.Reference,
        let tags = ckRecord[RequestConstants.tagsKey] as? [String],
            let imageAsset = ckRecord[RequestConstants.imageKey] as? CKAsset else { return nil }
        
        self.username = username
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.responseCount = responseCount
        self.userReference = userReference
        self.recordID = ckRecord.recordID
        self.tags = tags
        
        guard let url = imageAsset.fileURL else { return }
               
               do {
                   self.imageData = try Data(contentsOf: url)
               } catch {
                   print("Error converting imageAsset to Data \(error) \(error.localizedDescription)")
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
        self.setValue(request.tags, forKey: RequestConstants.tagsKey)
        self.setValue(request.imageAsset, forKey: RequestConstants.imageKey)
    }
}
