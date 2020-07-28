//
//  TaskDetailsCoordinator.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class TaskDetailsCoordinator: CoordinatorProtocol{
    private let navigationController: UINavigationController
    var task: Task!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let taskDetailsViewModel = TaskDetailsViewModel()
        taskDetailsViewModel.task = task
        taskDetailsViewModel.coordinator = self
        let taskDetailsVC = TaskDetailsVC()
        taskDetailsVC.viewModel = taskDetailsViewModel
        let taskDetailsNavigationController = UINavigationController(rootViewController: taskDetailsVC)
        navigationController.present(taskDetailsNavigationController, animated: true, completion: nil)
    }
    
    func dismiss(){
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func saved(){
        if let taskVC = self.navigationController.viewControllers.last as? TaskVC{
            taskVC.reloadTasks()
        }
        dismiss()
    }
}
