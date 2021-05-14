//
//  ListingServices.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import Combine

protocol ListingServiceProtocol {
    
    var networkManager: NetworkManagerProtocol { get }
    
    func getTopReddits() -> AnyPublisher<RedditList, Error>
    
}

struct ListingServices: ListingServiceProtocol {
    
    static let shared: ListingServices = {
        guard let manager = AppDelegate.sharedNetworkManager else {
            preconditionFailure("Missing Network Manager")
        }
        return ListingServices(networkManager: manager)
    }()
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getTopReddits() -> AnyPublisher<RedditList, Error> {
        let request = HTTPRequest<EmptyData, RedditList>(endpoint: Endpoint.topJSON)
        return self.networkManager.request(request)
    }
    
}
