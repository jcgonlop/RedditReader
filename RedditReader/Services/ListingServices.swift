//
//  ListingServices.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

struct ListingServices {
    
    static let getTopReddits: HTTPRequest = HTTPRequest<EmptyData, RedditList>(endpoint: Endpoint.topJSON)
    
}
