//
//  ProjectListViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class ProjectListViewModel {
    private var dataRepository: ProjectDataRepositoryProtocol
    var coordinator: ProjectCoordinator!
    var projects: [Project] = []
    
    var cells: Box<[ProjectViewModel]> = Box([])
    var newProject: Box<ProjectViewModel?> = Box(nil)
    var deleted: Box<(Bool?, IndexPath?)> = Box((nil, nil))

    init(dataRepository: ProjectDataRepositoryProtocol = ProjectDataRepository()) {
        self.dataRepository = dataRepository
    }
    
    func viewDidLoad(){
        dataRepository.getAll { [weak self] (projects) in
            guard let self = self else { return }
            self.projects = projects.reversed()
            let projectsVM = projects.map({ ProjectViewModel(project: $0) })
            self.cells.value = projectsVM.reversed()
        }
    }
    
    func projectDidAdd(name: String){
        dataRepository.add(name: name){ [weak self] (project) in
            guard let self = self, let project = project else { return }
            self.projects.insert(project, at: 0)
            self.newProject.value = ProjectViewModel(project: project)
        }
    }
    
    func projectDidDelete(at indexPath: IndexPath){
        dataRepository.delete(project: projects[indexPath.item]){ [weak self] (completed) in
            guard let self = self, let completed = completed else { return }
            if completed{
                self.projects.remove(at: indexPath.item)
                self.deleted.value = (true, indexPath)
            }else{
                self.deleted.value = (false, indexPath)
            }
        }
    }
    
    func projectDidSelect(at indexPath: IndexPath){
        coordinator.pushToTaskVC(project: projects[indexPath.item])
    }

}
