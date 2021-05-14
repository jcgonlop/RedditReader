//
//  RedditListView.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import UIKit
import Combine

class RedditListView: UITableView {
    
    var viewModel: RedditListViewModel
    var cancellables: Set<AnyCancellable> = []
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Initializers
    
    init(viewModel: RedditListViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero, style: .plain)
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Get me more")
        self.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.setupBindings()
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RedditListViewModel(listingService: ListingServices.shared)
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    func setupView() {
        self.spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0),
        ])
        if let refreshControl = self.refreshControl {
            self.addSubview(refreshControl)
        }
    }
    
    func setupBindings() {
        viewModel.postsList.sink { [weak self] newValue in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            if !newValue.isEmpty {
                self.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel.fetchPosts()
    }
    
}
