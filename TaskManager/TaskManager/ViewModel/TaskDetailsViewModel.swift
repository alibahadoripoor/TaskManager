//
//  CommentListViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class TaskDetailsViewModel {
    private var taskDataRepository: TaskDataRepositoryProtocol
    private var commentDataRepository: CommentDataRepositoryProtocol
    var coordinator: TaskDetailsCoordinator!
    var task: Task!
    private var comments: [Comment] = []
    
    var header: Box<TaskViewModel?> = Box(nil)
    var cells: Box<[CommentViewModel]> = Box([])
    var newComment: Box<CommentViewModel?> = Box(nil)
    var deleted: Box<(Bool?, IndexPath?)> = Box((nil, nil))
    var updated: Box<Bool?> = Box(nil)
    
    init(taskDataRepository: TaskDataRepositoryProtocol = TaskDataRepository(),
         commentDataRepository: CommentDataRepositoryProtocol = CommentDataRepository()) {
        self.taskDataRepository = taskDataRepository
        self.commentDataRepository = commentDataRepository
    }
    
    func viewDidLoad(){
        header.value = TaskViewModel(task: task)
        commentDataRepository.getAll(where: task) { [weak self] (comments) in
            guard let self = self else { return }
            self.comments = comments
            self.cells.value = comments.map({ CommentViewModel(comment: $0) })
        }
    }
    
    func taskDidUpdate(inputData: TaskInputData){
        taskDataRepository.update(task: task, inputData: inputData) { [weak self] (_) in
            guard let self = self else { return }
            self.coordinator.saved()
        }
    }
    
    func commentDidAdd(text: String){
        commentDataRepository.add(task: task, text: text) { [weak self] (comment) in
            guard let self = self, let comment = comment else { return }
            self.comments.append(comment)
            self.newComment.value = CommentViewModel(comment: comment)
        }
    }
    
    func commentDidDelete(at indexPath: IndexPath){
        commentDataRepository.delete(comment: comments[indexPath.item]) { [weak self] (deleted) in
            guard let self = self , let deleted = deleted else { return }
            if deleted{
                self.comments.remove(at: indexPath.item)
                self.deleted.value = (true, indexPath)
            }else{
                self.deleted.value = (false, indexPath)
            }
        }
    }
    
    func cancelButtonClicked(){
        coordinator.dismiss()
    }
    
}
