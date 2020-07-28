//
//  CommentLocalDataSource.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation
import CoreData

final class CommentLocalDataSource: CommentDataSourceProtocol {
    private var dataController: DataController
    
    init(dataController: DataController = .shared) {
        self.dataController = dataController
    }
    
    func add(task: Task, text: String) -> Comment? {
        let comment = Comment(context: dataController.viewContext)
        comment.task = task
        comment.text = text
        
        if dataController.save(){
            return comment
        }else{
            return nil
        }
    }
    
    func delete(comment: Comment) -> Bool {
        return dataController.delete(object: comment)
    }
    
    func getAll(where task: Task) -> [Comment] {
        let predicate = NSPredicate(format: "task == %@", task)
        return dataController.getAll(predicate: predicate)
    }
}
