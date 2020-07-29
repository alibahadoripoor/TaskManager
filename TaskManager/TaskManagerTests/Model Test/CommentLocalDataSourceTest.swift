//
//  CommentLocalDataSourceTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class CommentLocalDataSourceTest: XCTestCase {
    var projectLocalDataSource: ProjectDataSourceProtocol!
    var taskLocalDataSource: TaskDataSourceProtocol!
    var commentLocalDataSource: CommentDataSourceProtocol!
    
    var task: Task!
    
    override func setUp() {
        super.setUp()
        let dataController = DataControllerMock()
        projectLocalDataSource = ProjectLocalDataSource(dataController: dataController)
        taskLocalDataSource = TaskLocalDataSource(dataController: dataController)
        commentLocalDataSource = CommentLocalDataSource(dataController: dataController)
        
        if let project = projectLocalDataSource.add(name: "Test Project"){
            let inputData = TaskInputData(title: "Test Task", des: "Test Description", inReview: true)
            if let task = taskLocalDataSource.add(project: project, inputData: inputData){
                self.task = task
            }
        }
    }
    
    func testAddComment(){
        let comment = commentLocalDataSource.add(task: task, text: "Test Comment")
        XCTAssertEqual(comment?.text, "Test Comment")
    }
    
    func testDeleteComment(){
        let comment = commentLocalDataSource.add(task: task, text: "Test Comment")
        XCTAssertNotNil(comment)
        
        let deleted = commentLocalDataSource.delete(comment: comment!)
        XCTAssertTrue(deleted)
    }
    
    func testGetAllComments(){
        let comment1 = commentLocalDataSource.add(task: task, text: "Test Comment1")
        XCTAssertNotNil(comment1)
        
        let comment2 = commentLocalDataSource.add(task: task, text: "Test Comment2")
        XCTAssertNotNil(comment2)
        
        let tasks = commentLocalDataSource.getAll(where: task)
        XCTAssertEqual(tasks.count, 2)
    }
}
