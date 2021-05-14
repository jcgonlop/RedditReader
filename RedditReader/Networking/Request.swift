//
//  Request.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

public struct EmptyData: Codable {}

public protocol RequestProtocol {
    
    associatedtype Request: Codable
    associatedtype Response: Codable
    
    var endpoint: EndpointProtocol { get }
    var method: RequestMethod? { get }
    var queryItems: [URLQueryItem] { get }
    var requestData: Codable { get }
    var responseData: Codable { get }
    
}
