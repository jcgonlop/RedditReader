//
//  ViewModel.swift
//  RedditReader
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import Combine

public class Observable<T>: NSObject {
    
    var wrappedValue: T
    
    init(initialValue: T) {
        self.wrappedValue = initialValue
    }
    
}
