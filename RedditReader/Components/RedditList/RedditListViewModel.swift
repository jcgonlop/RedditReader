//
//  RedditListViewModel.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import UIKit
import Combine

class RedditListViewModel: NSObject {
    
    var postsList = CurrentValueSubject<[RedditPostViewModel], Never>([])
    private var redditListSubscription: AnyCancellable?
    private var currentPage: Int = 0
    private var batchSize: Int = 10
    
    override init() {
        
    }
    
    deinit {
        self.cancel()
    }
    
    func fetchPosts(fromPage page: Int = 0) {
        // Since the endpoint provided don't support pagination we will fake it
        if let currentSubscription = redditListSubscription {
            currentSubscription.cancel()
        }
        self.redditListSubscription = AppDelegate.sharedNetworkManager?.request(ListingServices.getTopReddits).sink(receiveCompletion: { (receivedCompletion) in
            switch receivedCompletion {
            case .finished:
                print("Finished")
                self.redditListSubscription = nil
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { (response) in
            print("Fetched data successfully")
            let newList = RedditListModel(response).redditPostList.map {
                RedditPostViewModel(model: $0)
            }
            if page == 0 {
                self.postsList.send(newList)
            } else {
                self.currentPage += 1
                self.postsList.send(self.postsList.value + newList.prefix(self.batchSize))
            }
        })
    }
    
    func fetchNext() {
        self.fetchPosts(fromPage: currentPage + 1)
    }
    
    func cancel() {
        redditListSubscription?.cancel()
    }
    
}
