//
//  TaskDataRepositpry.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class TaskDataRepository: TaskDataRepositoryProtocol {
    private let localDataSource: TaskDataSourceProtocol
    
    public init(localDataSource: TaskDataSourceProtocol = TaskLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    func add(project: Project, inputData: TaskInputData, completion: @escaping taskCompletion) {
        completion(localDataSource.add(project: project, inputData: inputData))
    }
    
    func delete(task: Task, completion: @escaping booleanCompletion) {
        completion(localDataSource.delete(task: task))
    }
    
    func update(task: Task, inputData: TaskInputData, completion: @escaping taskCompletion) {
        completion(localDataSource.update(task: task, inputData: inputData))
    }
    
    func getAll(where project: Project, completion: @escaping tasksCompletion) {
        completion(localDataSource.getAll(where: project))
    }
}
