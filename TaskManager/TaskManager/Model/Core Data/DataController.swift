//
//  DataManager.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import CoreData

final class DataController {
    static let shared = DataController()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TaskManagerDataModel")
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
        return persistentContainer
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
}

extension DataController{
    func getAll<T: NSManagedObject>(predicate: NSPredicate?) -> [T]{
        do{
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            
            if let predicate = predicate{
                fetchRequest.predicate = predicate
            }
            
            return try viewContext.fetch(fetchRequest)
        }catch{
            debugPrint(error)
            return []
        }
    }
    
    func save() -> Bool{
        do{
            try viewContext.save()
            return true
        }catch{
            debugPrint(error)
            return false
        }
    }
    
    func delete(object: NSManagedObject) -> Bool{
        do{
            viewContext.delete(object)
            try viewContext.save()
            return true
        }catch{
            debugPrint(error)
            return false
        }
    }
}
