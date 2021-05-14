//
//  RedditPostModel.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import CoreGraphics

struct RedditPostModel {
    
    let title: String
    let author: String
    let thumbnailURL: String
    let thumbnailSize: CGSize
    let subredditPrefixed: String
    let previews: [ImageModel]
    
    init(title: String, author: String,
         thumbnailURL: String, thumbnailSize: CGSize,
         subredditPrefixed: String, previews: [ImageModel] = []) {
        self.title = title
        self.author = author
        self.thumbnailURL = thumbnailURL
        self.thumbnailSize = thumbnailSize
        self.subredditPrefixed = subredditPrefixed
        self.previews = previews
    }
    
    init(_ dataModel: RedditPost) {
        self.title = dataModel.data.title
        self.author = dataModel.data.authorFullName
        self.thumbnailURL = dataModel.data.thumbnail
        self.thumbnailSize = CGSize(width: dataModel.data.thumbnailWidth,
                                    height: dataModel.data.thumbnailHeight)
        self.subredditPrefixed = dataModel.data.subredditNamePrefixed
        var previews: [ImageModel] = []
        if let preview = dataModel.data.preview {
            preview.images.forEach { (image) in
                image.resolutions.forEach { resolution in
                    previews.append(
                        ImageModel(
                            url: resolution.url,
                            size: CGSize(width: resolution.width, height: resolution.height)
                        )
                    )
                }
                previews.append(
                    ImageModel(
                        url: image.source.url,
                        size: CGSize(width: image.source.width, height: image.source.height)
                    )
                )
            }
        }
        self.previews = previews
    }
    
}

struct ImageModel {
    
    let url: String
    let size: CGSize
    
}
