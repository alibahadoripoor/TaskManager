//
//  TaskDataRepositoryMock.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

@testable import TaskManager

class TaskDataRepositoryMock: TaskDataRepositoryProtocol {
    func add(project: Project, inputData: TaskInputData, completion: @escaping taskCompletion) {
        completion(nil)
    }
    
    func delete(task: Task, completion: @escaping booleanCompletion) {
        completion(true)
    }
    
    func update(task: Task, inputData: TaskInputData, completion: @escaping taskCompletion) {
        completion(nil)
    }
    
    func getAll(where project: Project, completion: @escaping tasksCompletion) {
        completion([])
    }
}
