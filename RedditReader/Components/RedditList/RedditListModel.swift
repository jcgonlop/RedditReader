//
//  RedditListModel.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

struct RedditListModel {
    
    var redditPostList: [RedditPostModel]
    
    init(redditPostList: [RedditPostModel] = []) {
        self.redditPostList = redditPostList
    }
    
    init(_ dataModel: RedditList) {
        self.redditPostList = dataModel.data.children.map {
            RedditPostModel($0)
        }
    }
    
}
