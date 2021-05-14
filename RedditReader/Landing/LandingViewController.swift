//
//  ViewController.swift
//  RedditReader
//
//  Created by Juan Carlos on 13/05/21.
//

import UIKit

class LandingViewController: UIViewController {

    let stackView = UIStackView()
    let titleLabel = UILabel()
    var continueButton = UIButton()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupStackView()
        setupStackConstraints()
        setupLabel()
        setupContinueButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup Methods
    
    private func setupStackView() {
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
    }
    
    private func setupStackConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 20.0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 20.0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20)
        ])
        self.view.layoutIfNeeded()
    }
    
    private func setupLabel() {
        titleLabel.text = "Welcome to RedditReader v.1.0"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupContinueButton() {
        continueButton = UIButton(type: .roundedRect, primaryAction: UIAction(title: "Continue", state: .on, handler: { [weak self] (_) in
            guard let self = self else { return }
            self.continueAction(self.continueButton)
        }))
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        continueButton.tintColor = .customYellow
        self.stackView.addArrangedSubview(continueButton)
    }
    
    @objc func continueAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }

}
