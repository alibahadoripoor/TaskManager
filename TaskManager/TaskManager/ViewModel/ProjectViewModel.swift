//
//  ProjectViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class ProjectViewModel {
    let name: String
    
    init(project: Project){
        self.name = project.name!
    }
}
