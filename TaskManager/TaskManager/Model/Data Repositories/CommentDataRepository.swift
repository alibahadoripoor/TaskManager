//
//  CommentDataRepository.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class CommentDataRepository: CommentDataRepositoryProtocol {
    private let localDataSource: CommentDataSourceProtocol
    
    public init(localDataSource: CommentDataSourceProtocol = CommentLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func add(task: Task, text: String, completion: @escaping commentCompletion) {
        completion(localDataSource.add(task: task, text: text))
    }

    func delete(comment: Comment, completion: @escaping booleanCompletion) {
        completion(localDataSource.delete(comment: comment))
    }
    
    func getAll(where task: Task, completion: @escaping commentsCompletion) {
        completion(localDataSource.getAll(where: task))
    }
}
