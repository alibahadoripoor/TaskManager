//
//  ProjectViewModelTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 28.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class ProjectListViewModelTest: XCTestCase {
    var viewModel: ProjectListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ProjectListViewModel(dataRepository: ProjectDataRepositoryMock())
    }
    
    func testViewDidLoad(){
        let expectation = self.expectation(description: "View Did Load")
        
        viewModel.viewDidLoad()
        
        viewModel.cells.bind { (cells) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testProjectDidAdd(){
        let expectation = self.expectation(description: "Project Did Add")
        
        viewModel.projectDidAdd(name: "Test Project")
        
        viewModel.newProject.bind { (project) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testProjectDidDelete(){
        let expectation = self.expectation(description: "Project Did Delete")
        
        viewModel.projects.append(Project())
        
        viewModel.projectDidDelete(at: IndexPath(item: 0, section: 0))
                
        viewModel.deleted.bind { (deleted, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
