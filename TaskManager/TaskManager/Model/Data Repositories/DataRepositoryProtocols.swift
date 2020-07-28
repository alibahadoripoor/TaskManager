//
//  DataRepositoryProtocol.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

typealias booleanCompletion = (Bool?)->()
typealias projectsCompletion = ([Project])->()
typealias projectCompletion = (Project?)->()
typealias tasksCompletion = ([Task])->()
typealias taskCompletion = (Task?)->()
typealias commentsCompletion = ([Comment])->()
typealias commentCompletion = (Comment?)->()

protocol ProjectDataRepositoryProtocol {
    func add(name: String, completion: @escaping projectCompletion)
    func delete(project: Project, completion: @escaping booleanCompletion)
    func getAll(completion: @escaping projectsCompletion)
}

protocol TaskDataRepositoryProtocol {
    func add(project: Project, inputData: TaskInputData, completion: @escaping taskCompletion)
    func delete(task: Task, completion: @escaping booleanCompletion)
    func update(task: Task, inputData: TaskInputData, completion: @escaping taskCompletion)
    func getAll(where project: Project, completion: @escaping tasksCompletion)
}

protocol CommentDataRepositoryProtocol {
    func add(task: Task, text: String, completion: @escaping commentCompletion)
    func delete(comment: Comment, completion: @escaping booleanCompletion)
    func getAll(where task: Task, completion: @escaping commentsCompletion)
}
