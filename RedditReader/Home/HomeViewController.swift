//
//  HomeViewController.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var redditListViewModel = RedditListViewModel(listingService: ListingServices.shared)
    var redditListView: RedditListView
    
    // MARK: - Initializers
    
    init() {
        self.redditListView = RedditListView(viewModel: self.redditListViewModel)
        super.init(nibName: nil, bundle: nil)
        self.redditListView.delegate = self
        self.redditListView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        self.redditListView = RedditListView(viewModel: self.redditListViewModel)
        super.init(nibName: nil, bundle: nil)
        self.redditListView.delegate = self
        self.redditListView.dataSource = self
    }
    
    // MARK: - UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        redditListViewModel.fetchPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        redditListViewModel.cancel()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.redditListView.beginUpdates()
        self.redditListView.layoutSubviews()
        self.redditListView.endUpdates()
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraints() {
        redditListView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(redditListView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: redditListView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: redditListView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: redditListView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: redditListView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
    }
    
    func setupTableView() {
        self.view.backgroundColor = .lightBackground
        self.title = "Home"
        self.navigationItem.titleView?.tintColor = .lightBackground
        redditListView.register(RedditPostCell.self, forCellReuseIdentifier: RedditPostCell.reuseIdentifier)
        redditListView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        redditListView.separatorStyle = .none
        redditListView.rowHeight = UITableView.automaticDimension
        redditListView.estimatedRowHeight = 160.0
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == redditListViewModel.postsList.value.count {
            return 60
        }
        let vm = redditListViewModel.postsList.value[indexPath.row]
        return vm.thumbnailSize.height + 24
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditListViewModel.postsList.value.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == redditListViewModel.postsList.value.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as? LoadingTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RedditPostCell.reuseIdentifier, for: indexPath) as? RedditPostCell else {
                return UITableViewCell()
            }
            cell.setupView(viewModel: redditListViewModel.postsList.value[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: LoadingTableViewCell.self) {
            self.redditListViewModel.fetchNext()
        }
    }
    
}
