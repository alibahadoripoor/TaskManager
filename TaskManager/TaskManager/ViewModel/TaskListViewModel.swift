//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class TaskListViewModel {
    private var dataRepository: TaskDataRepositoryProtocol
    var coordinator: TaskCoordinator!
    var project: Project!
    private var tasks: [Task] = []
    
    var cells: Box<[TaskViewModel]> = Box([])
    var newTask: Box<TaskViewModel?> = Box(nil)
    var deleted: Box<(Bool?, IndexPath?)> = Box((nil, nil))
    
    init(dataRepository: TaskDataRepositoryProtocol = TaskDataRepository()) {
        self.dataRepository = dataRepository
    }
    
    func viewDidLoad(){
        dataRepository.getAll(where: project) { [weak self] (tasks) in
            guard let self = self else { return }
            self.tasks = tasks.reversed()
            let taskVMs = tasks.map({ TaskViewModel(task: $0) })
            self.cells.value = taskVMs.reversed()
        }
    }
    
    func taskDidAdd(inputData: TaskInputData){
        dataRepository.add(project: project, inputData: inputData) { [weak self] (task) in
            guard let self = self, let task = task else { return }
            self.tasks.insert(task, at: 0)
            self.newTask.value = TaskViewModel(task: task)
        }
    }
    
    func taskDidDelete(at indexPath: IndexPath){
        dataRepository.delete(task: tasks[indexPath.item]) { [weak self] (deleted) in
            guard let self = self, let deleted = deleted else { return }
            if deleted{
                self.tasks.remove(at: indexPath.item)
                self.deleted.value = (true, indexPath)
            }else{
                self.deleted.value = (false, indexPath)
            }
        }
    }
    
    func taskDidSelect(at indexPath: IndexPath){
        coordinator.presentTaskDetailsVC(task: tasks[indexPath.item])
    }
}
