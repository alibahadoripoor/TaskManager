//
//  TaskDetailsViewModelTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class TaskDetailsViewModelTest: XCTestCase {
    var viewModel: TaskDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TaskDetailsViewModel(taskDataRepository: TaskDataRepositoryMock(),
                                         commentDataRepository: CommentDataRepositoryMock())
        viewModel.task = Task()
    }
    
    func testGetAllComments(){
        let expectation = self.expectation(description: "All Comments Did Get")
        
        viewModel.getAllComments()
        
        viewModel.cells.bind { (_) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCommentDidAdd(){
        let expectation = self.expectation(description: "Comment Did Add")
        
        viewModel.commentDidAdd(text: "")

        viewModel.newComment.bind { (_) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTaskDidDelete(){
        let expectation = self.expectation(description: "Comment Did Delete")
        
        viewModel.comments.append(Comment())

        viewModel.commentDidDelete(at: IndexPath(item: 0, section: 0))

        viewModel.deleted.bind { (_, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
