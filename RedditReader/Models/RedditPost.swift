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
    let data: ResponseData
    
    struct ResponseData: Codable {
        
        let title: String
        let authorFullName: String
        let thumbnailHeight: Double
        let thumbnailWidth: Double
        let thumbnail: String
        let subreddit: String
        let subredditNamePrefixed: String
        let preview: Preview?
        
        private enum CodingKeys: String, CodingKey {
            case subreddit
            case title
            case thumbnail
            case preview
            case authorFullName = "author_fullname"
            case thumbnailHeight = "thumbnail_height"
            case thumbnailWidth = "thumbnail_width"
            case subredditNamePrefixed = "subreddit_name_prefixed"
        }
        
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
