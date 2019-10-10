//
//  UnsplashPhoto.swift
//  DummyProjectUnsplash
//
//  Created by Blake kvarfordt on 9/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

struct PhotoSearchDictionary: Decodable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    
    let urls: URLGroup
    let description: String?
}

struct URLGroup: Decodable {
    let small: String
    let regular: String
}
