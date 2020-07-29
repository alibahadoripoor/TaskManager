//
//  CommentDataRepositoryMock.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

@testable import TaskManager

class CommentDataRepositoryMock: CommentDataRepositoryProtocol {
    func add(task: Task, text: String, completion: @escaping commentCompletion) {
        completion(nil)
    }
    
    func delete(comment: Comment, completion: @escaping booleanCompletion) {
        completion(true)
    }
    
    func getAll(where task: Task, completion: @escaping commentsCompletion) {
        completion([])
    }
}
