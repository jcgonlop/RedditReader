//
//  RedditPost.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

struct RedditPost: Codable {
    
    let kind: String
    let data: String
    
    struct ResponseData: Codable {
        
        let subredit: String
        let title: String
        let authorFullName: String
        let thumbnailHeight: Double
        let thumbnailWidth: Double
        let thumbnail: String
        let subredditNamePrefixed: String
        let preview: Preview?
        
    }
    
    struct Preview: Codable {
        let images: [Image]
    }
    
    struct Image: Codable {
        
        let id: String
        let source: Source
        let resolutions: [Source]
        
        struct Source: Codable {
            let url: String
            let width: Double
            let height: Double
        }
        
    }
    
}
