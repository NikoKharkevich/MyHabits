//
//  AddNewHabbitViewController.swift
//  MyHabits
//
//  Created by Nikola Kharkevich on 21.06.2021.
//

import UIKit

class AddNewHabbitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()

    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem?.tintColor = .purple
    }

}
