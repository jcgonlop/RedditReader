//
//  MockNetworkManager.swift
//  RedditReaderTests
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import Combine
@testable import RedditReader

class MockNetworkManager: NetworkManagerProtocol {
    
    var baseURL: String = "https://mock.api.reddit.com"
    
    enum MockError: Error {
        case badJSON
    }
    
    init() {}
    
    func request<Request>(_ request: Request) -> AnyPublisher<Request.Response, Error> where Request : RequestProtocol {
        let fileName = request.endpoint.path
        guard let jsonData = LocalJSONFetcher.fetchLocalFile(fileName),
              let decodedData = try? JSONDecoder().decode(Request.Response.self, from: jsonData) else {
            return Fail(error: URLError(.cannotDecodeRawData))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
        return Just(decodedData)
            .setFailureType(to: Error.self)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
