//
//  AppCoordinator.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class{
    func start()
}

final class AppCoordinator: CoordinatorProtocol{
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start(){
        let navigationController = UINavigationController()
        let projectCoordinator = ProjectCoordinator(navigationController: navigationController)
        projectCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
