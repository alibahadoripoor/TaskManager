//
//  ProjectCoordinator.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class ProjectCoordinator: CoordinatorProtocol{
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let projectListViewModel = ProjectListViewModel()
        projectListViewModel.coordinator = self
        let projectVC = ProjectVC()
        projectVC.viewModel = projectListViewModel
        navigationController.viewControllers = [projectVC]
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func pushToTaskVC(project: Project){
        let taskCoordinator = TaskCoordinator(navigationController: navigationController)
        taskCoordinator.project = project
        taskCoordinator.start()
    }
}
