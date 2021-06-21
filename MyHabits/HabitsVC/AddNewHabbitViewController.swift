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
        view.backgroundColor = .lightGray

    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Создать"
        navigationItem.leftBarButtonItem?.title = "Отменить"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .yellow
//        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveHabit))
    }
    
    @objc func saveHabit() {
 
    }

}
