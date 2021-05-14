//
//  RedditPostViewModel.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import UIKit
import Combine

class RedditPostViewModel: NSObject {
    
    var title: String
    var subreddit: String
    var author: String
    var thumbnailPublisher = PassthroughSubject<UIImage, Never>()
    var thumbnailSize: CGSize
    
    init(model: RedditPostModel) {
        self.title = model.title
        self.author = model.author
        self.subreddit = model.subredditPrefixed
        self.thumbnailSize = model.thumbnailSize
    }
    
    override init() {
        self.title = ""
        self.author = ""
        self.subreddit = ""
        self.thumbnailSize = CGSize.zero
    }
    
}
