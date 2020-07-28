//
//  TaskLocalDataSource.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import CoreData

struct TaskInputData{
    let title: String
    let des: String?
    let inReview: Bool
}

final class TaskLocalDataSource: TaskDataSourceProtocol {
    private var dataController: DataController
    
    init(dataController: DataController = .shared) {
        self.dataController = dataController
    }
    func add(project: Project, inputData: TaskInputData) -> Task? {
        let task = Task(context: dataController.viewContext)
        task.project = project
        task.title = inputData.title
        task.des = inputData.des
        task.creationDate = Date()
        task.inReview = inputData.inReview
        
        if dataController.save(){
            return task
        }else{
            return nil
        }
    }
    
    func delete(task: Task) -> Bool {
        return dataController.delete(object: task)
    }
    
    func update(task: Task, inputData: TaskInputData) -> Task? {
        task.title = inputData.title
        task.des = inputData.des
        task.inReview = inputData.inReview
        
        if dataController.save(){
            return task
        }else{
            return nil
        }
    }
    
    func getAll(where project: Project) -> [Task] {
        let predicate = NSPredicate(format: "project == %@", project)
        return dataController.getAll(predicate: predicate)
    }
}
