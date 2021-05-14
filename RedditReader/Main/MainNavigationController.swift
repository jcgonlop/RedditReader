//
//  MainNavigationController.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backgroundColor = UIColor.darkBackground
        self.navigationBar.isOpaque = true
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.darkBackground
        self.navigationBar.tintColor = UIColor.lightBackground
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightBackground]
    }
    
}
