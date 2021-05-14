//
//  RDTNetworkManager.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    
    var baseURL: String { get }
    
    func request<Request: RequestProtocol>(_ request: Request) -> AnyPublisher<Request.Response, Error>
    
}

public class HTTPNetworkManager: NetworkManagerProtocol {
    
    public var baseURL: String
    private var defaultSession: URLSession
    private var cancellables: Set<AnyCancellable> = []
    private var backgroundScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    
    public init(baseURL: String) {
        self.baseURL = baseURL
        self.defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func request<Request: RequestProtocol>(_ request: Request) -> AnyPublisher<Request.Response, Error> {
        guard let url = request.endpoint.url(withBaseURL: self.baseURL, queryItems: request.queryItems) else {
            // TODO: Handle error
            preconditionFailure("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method?.rawValue
        return defaultSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Request.Response.self, decoder: JSONDecoder())
            .subscribe(on: backgroundScheduler)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
