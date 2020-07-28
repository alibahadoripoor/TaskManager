//
//  LocalDataSource.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import CoreData

final class ProjectLocalDataSource: ProjectDataSourceProtocol {
    private var dataController: DataController
    
    init(dataController: DataController = .shared) {
        self.dataController = dataController
    }
    
    func add(name: String) -> Project? {
        let project = Project(context: dataController.viewContext)
        project.name = name
        
        if dataController.save(){
            return project
        }else{
            return nil
        }
    }
    
    func delete(project: Project) -> Bool {
        return dataController.delete(object: project)
    }
    
    func getAll() -> [Project] {
        return dataController.getAll(predicate: nil)
    }
}
