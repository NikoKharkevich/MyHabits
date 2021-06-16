//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Nikola Kharkevich on 16.06.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = infoViewTextLabel
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let textDescription: UILabel = {
        let label = UILabel()
        label.text = infoViewTextDescription
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(textLabel, textDescription)
        
        scrollView.toAutoLayout()
        containerView.toAutoLayout()
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            textDescription.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            textDescription.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textDescription.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
