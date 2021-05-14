//
//  RedditPostCell.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import UIKit
import Combine

class RedditPostCell: UITableViewCell {

    static let reuseIdentifier: String = "RedditPostCell"
    
    var viewModel: RedditPostViewModel
    var imageDataSubscription: AnyCancellable?
    
    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var subRedditLabel = UILabel()
    private var thumbnailImage = UIImageView(image: .placeholder)
    private var mainStack = UIStackView()
    private var detailStack = UIStackView()
    
    private var thumbnailHeightConstraint: NSLayoutConstraint?
    private var thumbnailWidthConstraint: NSLayoutConstraint?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = RedditPostViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = RedditPostViewModel()
        super.init(style: .default, reuseIdentifier: RedditPostCell.reuseIdentifier)
    }
    
    // MARK: - Setup Methods
    
    func initialSetup() {
        contentView.addSubview(mainStack)
        let mainStackHeightConstraint = NSLayoutConstraint(item: mainStack, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
        mainStackHeightConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStackHeightConstraint,
        ])
        contentView.backgroundColor = .clear
    }
    
    func setupView(viewModel: RedditPostViewModel) {
        self.viewModel = viewModel
        setupBindings()
        setupMainStack()
        setupThumbnail()
        setupDetail()
        viewModel.fetchImage()
    }
    
    private func setupMainStack() {
        self.mainStack.axis = .horizontal
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.mainStack.distribution = .fillProportionally
        mainStack.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        mainStack.spacing = 12
        mainStack.backgroundColor = .timberwolf
        mainStack.layer.cornerRadius = 12
        mainStack.clipsToBounds = true
    }
    
    private func setupDetail() {
        self.detailStack.axis = .vertical
        self.detailStack.translatesAutoresizingMaskIntoConstraints = false
        self.detailStack.distribution = .fillProportionally
        self.mainStack.addArrangedSubview(detailStack)
        detailStack.spacing = 10
        detailStack.didMoveToSuperview()
        setupSubredditLabel()
        setupTitle()
        setupAuthorLabel()
    }
    
    private func setupTitle() {
        self.titleLabel.text = viewModel.title
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.textColor = .darkBackground
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailStack.addArrangedSubview(titleLabel)
        titleLabel.didMoveToSuperview()
    }
    
    private func setupAuthorLabel() {
        self.authorLabel.text = "Written by: \(viewModel.author)"
        self.authorLabel.numberOfLines = 1
        self.authorLabel.font = UIFont.systemFont(ofSize: 12)
        self.authorLabel.textColor = .lightDark
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailStack.addArrangedSubview(authorLabel)
        authorLabel.didMoveToSuperview()
    }
    
    private func setupSubredditLabel() {
        self.subRedditLabel.text = viewModel.subreddit
        self.subRedditLabel.numberOfLines = 1
        self.subRedditLabel.font = UIFont.systemFont(ofSize: 10)
        self.subRedditLabel.textColor = .lightDark
        self.subRedditLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailStack.addArrangedSubview(subRedditLabel)
        subRedditLabel.didMoveToSuperview()
    }
    
    private func setupThumbnail() {
        self.thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailImage.contentMode = .scaleAspectFit
        self.thumbnailImage.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        if let heightConstraint = self.thumbnailHeightConstraint {
            heightConstraint.constant = self.viewModel.thumbnailSize.height
        } else {
            let constraint = NSLayoutConstraint(item: self.thumbnailImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.viewModel.thumbnailSize.height)
            self.thumbnailHeightConstraint = constraint
            self.thumbnailWidthConstraint?.priority = .defaultHigh
            self.thumbnailImage.addConstraint(constraint)
        }
        if let widthConstraint = self.thumbnailWidthConstraint {
            widthConstraint.constant = self.viewModel.thumbnailSize.width
        } else {
            let constraint = NSLayoutConstraint(item: self.thumbnailImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.viewModel.thumbnailSize.width)
            self.thumbnailWidthConstraint = constraint
            self.thumbnailImage.addConstraint(constraint)
        }
        self.mainStack.addArrangedSubview(self.thumbnailImage)
        self.thumbnailImage.didMoveToSuperview()
    }
    
    private func setupBindings() {
        imageDataSubscription = self.viewModel.thumbnailPublisher.sink { (newImage) in
            self.thumbnailImage.image = newImage
        }
    }
    
}
