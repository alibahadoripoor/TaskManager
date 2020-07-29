//
//  TestCoreData.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 28.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import CoreData
@testable import TaskManager

class DataControllerMock: DataController {
    override init() {
        super.init()
        self.viewContext = {
            return setUpInMemoryManagedObjectContext()
        }()
    }
    
    private func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSInMemoryStoreType,
                configurationName: nil,
                at: nil,
                options: nil
            )
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}


