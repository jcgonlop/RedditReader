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
    var loading = PassthroughSubject<Bool, Never>()
    private var redditListSubscription: AnyCancellable?
    
    override init() {
        
    }
    
    deinit {
        self.cancel()
    }
    
    func fetchPosts() {
        if let currentSubscription = redditListSubscription {
            currentSubscription.cancel()
        }
        self.loading.send(true)
        self.redditListSubscription = AppDelegate.sharedNetworkManager?.request(ListingServices.getTopReddits).sink(receiveCompletion: { (receivedCompletion) in
            switch receivedCompletion {
            case .finished:
                print("Finished")
                self.loading.send(false)
                self.redditListSubscription = nil
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { (response) in
            print("Fetched data successfully")
            self.postsList.send(
                RedditListModel(response).redditPostList.map {
                    RedditPostViewModel(model: $0)
                }
            )
        })
    }
    
    func cancel() {
        redditListSubscription?.cancel()
    }
    
}
