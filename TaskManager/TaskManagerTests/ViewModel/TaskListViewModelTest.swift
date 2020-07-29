//
//  TaskListViewModelTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class TaskListViewModelTest: XCTestCase {
    var viewModel: TaskListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TaskListViewModel(dataRepository: TaskDataRepositoryMock())
        viewModel.project = Project()
    }
    
    func testViewDidLoad(){
        let expectation = self.expectation(description: "View Did Load")
        
        viewModel.viewDidLoad()
        
        viewModel.cells.bind { (_) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testTaskDidAdd(){
        let expectation = self.expectation(description: "Task Did Add")
        
        let inputData = TaskInputData(title: "", des: "", inReview: true)
        
        viewModel.taskDidAdd(inputData: inputData)
        
        viewModel.newTask.bind { (_) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTaskDidDelete(){
        let expectation = self.expectation(description: "Task Did Delete")
        
        viewModel.tasks.append(Task())
        
        viewModel.taskDidDelete(at: IndexPath(item: 0, section: 0))
                
        viewModel.deleted.bind { (_, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
