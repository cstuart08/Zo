//
//  Response.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/2/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import AVKit
import CloudKit

struct ResponseConstants {
    static let responseKey = "response"
    static let usernameKey = "username"
    static let bodyTextKey = "bodyText"
    static let imageAssetKey = "imageAsset"
    static let linkKey = "link"
    static let timestampKey = "timestamp"
    static let responseTagsKey = "responseTags"
    static let responseRecordIDKey = "responseRecordID"
    static let requestReferenceKey = "requestReference"
}

class Response {
    var username: String
    var bodyText: String?
    var link: URL?
    var timestamp: Double
    var responseTags: [String]
    var responseRecordID: CKRecord.ID
    var requestReference: CKRecord.Reference
    var imageData: Data?
    var image: UIImage? {
        get {
            guard let imageData = self.imageData else { return nil }
            return UIImage(data: imageData)
        } set {
            self.imageData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var imageCkAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            
            do {
                try imageData?.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(username: String, bodyText: String?, image: UIImage?, link: URL?, timestamp: Double = Date().timeIntervalSince1970, responseTags: [String], responseRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), requestReference: CKRecord.Reference) {
        self.username = username
        self.bodyText = bodyText
        self.link = link
        self.timestamp = timestamp
        self.responseTags = responseTags
        self.responseRecordID = responseRecordID
        self.requestReference = requestReference
        self.image = image
    }
    
    // Pulling from CloudKit
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[ResponseConstants.usernameKey] as? String,
            let bodyText = ckRecord[ResponseConstants.bodyTextKey] as String?,
            let link = ckRecord[ResponseConstants.linkKey] as? URL?,
            let timestamp = ckRecord[ResponseConstants.timestampKey] as? Double,
            let responseTags = ckRecord[ResponseConstants.responseTagsKey] as? [String],
            let requestReference = ckRecord[ResponseConstants.requestReferenceKey] as? CKRecord.Reference,
            let imageCkAsset = ckRecord[ResponseConstants.imageAssetKey] as? CKAsset
            else { return nil }
        
        self.username = username
        self.bodyText = bodyText
        self.link = link
        self.timestamp = timestamp
        self.responseTags = responseTags
        self.responseRecordID = ckRecord.recordID
        self.requestReference = requestReference
        
        do {
            self.imageData = try Data(contentsOf: imageCkAsset.fileURL!)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}

// Pushing to CloudKit
extension CKRecord {
    convenience init(response: Response) {
        self.init(recordType: ResponseConstants.responseKey, recordID: response.responseRecordID)
        
        self.setValue(response.username, forKey: ResponseConstants.usernameKey)
        self.setValue(response.bodyText, forKey: ResponseConstants.bodyTextKey)
        self.setValue(response.imageCkAsset, forKey: ResponseConstants.imageAssetKey)
        self.setValue(response.link, forKey: ResponseConstants.linkKey)
        self.setValue(response.timestamp, forKey: ResponseConstants.timestampKey)
        self.setValue(response.responseTags, forKey: ResponseConstants.responseTagsKey)
        self.setValue(response.requestReference, forKey: ResponseConstants.requestReferenceKey)
    }
}

extension Response: Equatable {
    static func == (lhs: Response, rhs: Response) -> Bool {
        return lhs.username == rhs.username
    }
}
