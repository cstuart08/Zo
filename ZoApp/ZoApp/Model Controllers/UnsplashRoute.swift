//
//  UnsplashRoute.swift
//  DummyProjectUnsplash
//
//  Created by Blake kvarfordt on 9/30/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

enum UnsplashRoute {
    
    static let baseUrl = "https://api.unsplash.com/"
    //TODO: - Input Unsplash Client Id
    static let clientId = "99d9e9565212e82aa4f30e06aea5af619e4b755ab0ee2f0ba62d796c5d6aee88"
    
    case inspirationalQuote
    
    
    var path: String {
        switch self {
        case .inspirationalQuote:
            return "/photos/random"
        
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "client_id", value: UnsplashRoute.clientId),
            URLQueryItem(name: "count", value: "1")
        ]
        switch self {
        case .inspirationalQuote:
            items.append(URLQueryItem(name: "query", value: "inspirational quote"))
            return items
        }
    }
    
    var fullUrl: URL? {
        guard let url = URL(string: UnsplashRoute.baseUrl)?.appendingPathComponent(path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url
    }
}
