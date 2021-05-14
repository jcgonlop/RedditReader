//
//  MockListService.swift
//  RedditReaderTests
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import Combine
@testable import RedditReader

class MockListService: ListingServiceProtocol {
    
    var networkManager: NetworkManagerProtocol
    
    static let shared: MockListService = MockListService(networkManager: MockNetworkManager())
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getTopReddits() -> AnyPublisher<RedditList, Error> {
        let request = HTTPRequest<EmptyData, RedditList>(endpoint: Endpoint.mockedTopJSON)
        return networkManager.request(request)
    }
    
}

extension Endpoint {
    
    static public var mockedTopJSON: Endpoint {
        Endpoint(path: "top_reddit_list")
    }
    
}
