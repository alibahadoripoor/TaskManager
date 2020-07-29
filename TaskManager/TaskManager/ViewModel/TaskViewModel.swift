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
    let date: String
    let inReview: Bool
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init(task: Task) {
        self.title = task.title!
        self.des = task.des
        let date = dateFormatter.string(from: task.creationDate!)
        self.date = "Creation Date: \(date)"
        self.inReview = task.inReview
    }
}
