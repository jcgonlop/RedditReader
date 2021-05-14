//
//  LoaderView.swift
//  RedditReader
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0),
        ])
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    func showLoader(_ isLoading: Bool) {
        if isLoading {
            let loaderView = LoaderView()
            loaderView.trans@objc latesAutoresizingMaskIntoConstraints = false
            loaderView.accessibilityIdentifier = "loader"
            self.addSubview(loaderView)
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: loaderView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: loaderView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: loaderView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: loaderView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            ])
        } else {
            let loaderView = self.subviews.first { (view) in
                view.accessibilityIdentifier == "loader"
            }
            loaderView?.constraints.forEach({ (constraint) in
                loaderView?.removeConstraint(constraint)
            })
            loaderView?.removeFromSuperview()
        }
    }
    
}
