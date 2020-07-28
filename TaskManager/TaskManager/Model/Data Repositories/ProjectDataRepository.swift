//
//  DataRepository.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class ProjectDataRepository: ProjectDataRepositoryProtocol {
    private let localDataSource: ProjectDataSourceProtocol
    
    public init(localDataSource: ProjectDataSourceProtocol = ProjectLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func add(name: String, completion: @escaping projectCompletion) {
        completion(localDataSource.add(name: name))
    }
    
    func delete(project: Project, completion: @escaping booleanCompletion) {
        completion(localDataSource.delete(project: project))
    }
    
    func getAll(completion: @escaping projectsCompletion) {
        completion(localDataSource.getAll())
    }
}
