//
//  ProjectDataRepositoryMock.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 28.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

@testable import TaskManager

class ProjectDataRepositoryMock: ProjectDataRepositoryProtocol {
    func add(name: String, completion: @escaping projectCompletion) {
        completion(nil)
    }
    
    func delete(project: Project, completion: @escaping booleanCompletion) {
        completion(true)
    }
    
    func getAll(completion: @escaping projectsCompletion) {
        completion([])
    }
}
