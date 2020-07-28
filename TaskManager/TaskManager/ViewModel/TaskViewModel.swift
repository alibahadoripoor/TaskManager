//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class TaskViewModel {
    let title: String
    let des: String?
    let date: Date
    let inReview: Bool
    
    init(task: Task) {
        self.title = task.title!
        self.des = task.des
        self.date = task.creationDate!
        self.inReview = task.inReview
    }
}
