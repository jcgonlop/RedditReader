//
//  URLImageView.swift
//  RedditReader
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ImageFetcher {
    
    private static var backgroundScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    
    static func fetchImage(from url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) in
                guard let image = UIImage(data: data) else {
                    throw URLError(.resourceUnavailable)
                }
                return image
            })
            .subscribe(on: backgroundScheduler)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
