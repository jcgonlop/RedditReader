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
    var listBinding: AnyCancellable?
    
    // MARK: - Initializers
    
    init(viewModel: RedditListViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero, style: .plain)
        self.setupBindings()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RedditListViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    func setupBindings() {
        self.listBinding = viewModel.postsList.sink { [weak self] newValue in
            guard let self = self else { return }
            if !newValue.isEmpty {
                self.reloadData()
            }
        }
    }
    
}
