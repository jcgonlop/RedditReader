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
    var thumbnailPublisher = CurrentValueSubject<UIImage, Never>(.placeholder)
    var thumbnailSize: CGSize
    private let thumbnailURL: String
    private var imageFetchSubscription: AnyCancellable?
    
    init(model: RedditPostModel) {
        self.title = model.title
        self.author = model.author
        self.subreddit = model.subredditPrefixed
        self.thumbnailSize = model.thumbnailSize
        self.thumbnailURL = model.thumbnailURL
    }
    
    override init() {
        self.title = ""
        self.author = ""
        self.subreddit = ""
        self.thumbnailSize = CGSize.zero
        self.thumbnailURL = ""
    }
    
    func fetchImage() {
        if let currentSubscription = self.imageFetchSubscription {
            currentSubscription.cancel()
        }
        guard let imageURL = URL(string: thumbnailURL) else {
            print("Failed to load image")
            return
        }
        self.imageFetchSubscription = ImageFetcher.fetchImage(from: imageURL).sink { (receiveCompletion) in
            switch receiveCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                self.imageFetchSubscription = nil
            }
        } receiveValue: { image in
            self.thumbnailPublisher.send(image)
        }
    }
    
}
