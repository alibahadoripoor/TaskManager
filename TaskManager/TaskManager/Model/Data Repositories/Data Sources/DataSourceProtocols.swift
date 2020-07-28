//
//  DataSourceProtocol.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import CoreData

protocol ProjectDataSourceProtocol {
    func add(name: String) -> Project?
    func delete(project: Project) -> Bool
    func getAll() -> [Project]
//    func get(at id: NSManagedObjectID) -> Project?
}

protocol TaskDataSourceProtocol {
    func add(project: Project, inputData: TaskInputData) -> Task?
    func delete(task: Task) -> Bool
    func update(task: Task, inputData: TaskInputData) -> Task?
    func getAll(where project: Project) -> [Task]
//    func get(at id: NSManagedObjectID) -> Task?
}

protocol CommentDataSourceProtocol {
    func add(task: Task, text: String) -> Comment?
    func delete(comment: Comment) -> Bool
    func getAll(where task: Task) -> [Comment]
//    func get(at id: NSManagedObjectID) -> Comment?
}
