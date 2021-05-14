//
//  Endpoint.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

public protocol EndpointProtocol {
    
    var path: String { get }
    
}

public extension EndpointProtocol {
    
    func url(withBaseURL baseURL: String, queryItems: [URLQueryItem] = []) -> URL? {
        guard var components = URLComponents(string: baseURL+path) else { return nil }
        components.queryItems = queryItems
        return components.url
    }
    
}

public struct Endpoint: EndpointProtocol {
    
    public var path: String
    
    public init(path: String) {
        self.path = path
    }
    
}

extension Endpoint {
    
    static public var top: Endpoint {
        Endpoint(path: "/top")
    }
    
    static public var topJSON: Endpoint {
        Endpoint(path: "/top.json")
    }
    
}
