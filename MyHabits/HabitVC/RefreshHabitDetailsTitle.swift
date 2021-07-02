//
//  HabitViewSetup.swift
//  MyHabits
//
//  Created by Nikola Kharkevich on 02.07.2021.
//

import UIKit


protocol RefreshHabitDetailsTitle {
    func refreshTitle(newtitle: String)
}

extension HabitDetailsViewController: RefreshHabitDetailsTitle {    
    func refreshTitle(newtitle: String) {
        navigationItem.title = newtitle
    }
}

