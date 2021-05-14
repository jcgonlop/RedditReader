//
//  RequestMethod.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

public protocol RequestMethod {
    var rawValue: String { get }
}

public enum HTTPMethod: String, RequestMethod {
    case get = "GET"
    case post = "POST"
}
