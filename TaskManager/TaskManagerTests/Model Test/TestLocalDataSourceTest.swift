//
//  TestLocalDataSourceTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class TestLocalDataSourceTest: XCTestCase {
    var projectLocalDataSource: ProjectDataSourceProtocol!
    var taskLocalDataSource: TaskDataSourceProtocol!
    
    var project: Project!
    
    override func setUp() {
        super.setUp()
        let dataController = DataControllerMock()
        projectLocalDataSource = ProjectLocalDataSource(dataController: dataController)
        taskLocalDataSource = TaskLocalDataSource(dataController: dataController)
        
        if let project = projectLocalDataSource.add(name: "Test Project"){
            self.project = project
        }
    }
    
    func testAddTask(){
        let inputData = TaskInputData(title: "Test Task", des: "Test Description", inReview: true)
        let task = taskLocalDataSource.add(project: project, inputData: inputData)
        XCTAssertEqual(task?.title, "Test Task")
        XCTAssertEqual(task?.des, "Test Description")
        XCTAssertEqual(task?.inReview, true)
    }
    
    func testDeleteTask(){
        let inputData = TaskInputData(title: "Test Task", des: "Test Description", inReview: true)
        let task = taskLocalDataSource.add(project: project, inputData: inputData)
        XCTAssertNotNil(task)
        
        let deleted = taskLocalDataSource.delete(task: task!)
        XCTAssertTrue(deleted)
    }
    
    func testUpdateTask(){
        let inputData = TaskInputData(title: "Test Task", des: "Test Description", inReview: true)
        let task = taskLocalDataSource.add(project: project, inputData: inputData)
        XCTAssertNotNil(task)
        
        let newInputData = TaskInputData(title: "Test Updated Task", des: "Test Updated Description", inReview: false)
        let updatedTask = taskLocalDataSource.update(task: task!, inputData: newInputData)
        
        XCTAssertEqual(updatedTask?.title, "Test Updated Task")
        XCTAssertEqual(updatedTask?.des, "Test Updated Description")
        XCTAssertEqual(updatedTask?.inReview, false)
    }
    
    func testGetAllTasks(){
        let inputData = TaskInputData(title: "Test Task", des: "Test Description", inReview: true)
        let task = taskLocalDataSource.add(project: project, inputData: inputData)
        XCTAssertNotNil(task)
        
        let inputData2 = TaskInputData(title: "Test Task2", des: "Test Description2", inReview: true)
        let task2 = taskLocalDataSource.add(project: project, inputData: inputData2)
        XCTAssertNotNil(task2)
        
        let tasks = taskLocalDataSource.getAll(where: project)
        XCTAssertEqual(tasks.count, 2)
    }
}
