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
    
    func request<Request: RequestProtocol>(_ request: Request, handler: @escaping (Result<Request.Response, Error>) -> Void)
    
}

public class NetworkManager: NetworkManagerProtocol {
    
    public static let shared = NetworkManager()
    
    public var baseURL: String = ""
    private var didSetup: Bool = false
    private var defaultSession: URLSession
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        self.defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func setup(baseURL: String) {
        self.baseURL = baseURL
        self.didSetup = true
    }
    
    public func request<Request: RequestProtocol>(_ request: Request, handler: @escaping (Result<Request.Response, Error>) -> Void) {
        guard let url = request.endpoint.url(withBaseURL: self.baseURL, queryItems: request.queryItems) else {
            // TODO: Handle error
            preconditionFailure("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method?.rawValue
        defaultSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Request.Response.self, decoder: JSONDecoder())
            .sink( receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    handler(Result.failure(error))
                default:
                    break
                }
            }, receiveValue: { (value) in
                handler(Result.success(value))
            })
            .store(in: &self.cancellables)
    }
    
}
