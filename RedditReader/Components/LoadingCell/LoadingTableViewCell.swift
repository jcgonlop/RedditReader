//
//  LoadingTableViewCell.swift
//  RedditReader
//
//  Created by Juan Carlos on 14/05/21.
//  Copyright © 2021 Reddit. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LoadingCell"
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    private var mainStack = UIStackView()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: RedditPostCell.reuseIdentifier)
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Setup Methods
    
    func initialSetup() {
        self.selectionStyle = .none
        self.mainStack.axis = .vertical
        self.mainStack.alignment = .center
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.mainStack.distribution = .equalCentering
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
        contentView.backgroundColor = UIColor.customYellow.withAlphaComponent(0.5)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(spinner)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading"
        label.textColor = .lightDark
        mainStack.addArrangedSubview(label)
        spinner.startAnimating()
    }
    
}
