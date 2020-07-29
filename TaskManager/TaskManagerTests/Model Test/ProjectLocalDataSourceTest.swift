//
//  ProjectLocalDataSourceTest.swift
//  TaskManagerTests
//
//  Created by Ali Bahadori on 29.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import XCTest
@testable import TaskManager

class ProjectLocalDataSourceTest: XCTestCase {
    var localDataSource: ProjectDataSourceProtocol!
    
    override func setUp() {
        super.setUp()
        localDataSource = ProjectLocalDataSource(dataController: DataControllerMock())
    }
    
    func testAddProject(){
        let project = localDataSource.add(name: "Test Project")
        XCTAssertEqual(project?.name, "Test Project")
    }
    
    func testDeleteProject(){
        let project = localDataSource.add(name: "Test Project")
        XCTAssertNotNil(project)
        let deleted = localDataSource.delete(project: project!)
        XCTAssertTrue(deleted)
    }
    
    func testGetAllProjects(){
        let project1 = localDataSource.add(name: "Test Project1")
        XCTAssertNotNil(project1)
        let project2 = localDataSource.add(name: "Test Project2")
        XCTAssertNotNil(project2)
        
        let projects = localDataSource.getAll()
        XCTAssertGreaterThan(projects.count, 0)
    }
}
