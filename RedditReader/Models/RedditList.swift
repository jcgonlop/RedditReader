//
//  RedditList.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

struct RedditList: Codable {
    
    let kind: String
    let data: ResponseData
    
    struct ResponseData: Codable {
        
        let children: [RedditPost]
        let after: String?
        let before: String?
        
    }
    
}
