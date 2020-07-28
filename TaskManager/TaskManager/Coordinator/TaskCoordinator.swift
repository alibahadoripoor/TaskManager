//
//  TaskCoordinator.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class TaskCoordinator: CoordinatorProtocol{
    private let navigationController: UINavigationController
    var project: Project!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let taskListViewModel = TaskListViewModel()
        taskListViewModel.coordinator = self
        taskListViewModel.project = project
        let taskVC = TaskVC()
        taskVC.viewModel = taskListViewModel
        navigationController.pushViewController(taskVC, animated: true)
    }
    
    func presentTaskDetailsVC(task: Task){
        let taskDetailsCoordinator = TaskDetailsCoordinator(navigationController: navigationController)
        taskDetailsCoordinator.task = task
        taskDetailsCoordinator.start()
    }
}
