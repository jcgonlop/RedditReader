//
//  Bundle+extension.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var baseURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
    }
    
}
