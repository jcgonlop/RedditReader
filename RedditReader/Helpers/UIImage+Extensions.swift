//
//  UIImage+Extensions.swift
//  RedditReader
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static var placeholder: UIImage {
        guard let image = UIImage(named: "placeholder") else {
            preconditionFailure("Asset missing")
        }
        return image
    }
    
}
