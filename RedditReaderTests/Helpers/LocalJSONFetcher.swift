//
//  LocalJSONFetcher.swift
//  RedditReaderTests
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

class LocalJSONFetcher {
    
    static func fetchLocalFile(_ named: String) -> Data? {
        guard let bundlePath = Bundle(for: MockNetworkManager.self).path(forResource: named, ofType: "json"),
               let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) else  {
            return nil
            
        }
        return jsonData
    }
    
}
