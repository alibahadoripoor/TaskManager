//
//  TaskDetailsTableViewController.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class TaskDetailsVC: UIViewController {
    
    var viewModel: TaskDetailsViewModel!
    private var task: TaskViewModel?
    private var comments: [CommentViewModel] = []
    private let cellId = "cellId"
    private let tableView = UITableView()
    private let header = TaskDetailsHeader()
    private let footer = AddCommentFooter()
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        hideKeyboard()
        subscribeToKeyboardNotifications()
        
        viewModel.viewDidLoad()
        
        //Notifications from View model
        
        viewModel.header.bind { [weak self] (task) in
            guard let self = self, let task = task else { return }
            self.title = task.title
            self.task = task
            self.tableView.reloadData()
        }
        
        viewModel.cells.bind { [weak self] (comments) in
            guard let self = self else { return }
            self.comments = comments
            self.tableView.reloadData()
        }
        
        viewModel.newComment.bind { [weak self] (comment) in
            guard let self = self, let comment = comment else { return }
            self.comments.append(comment)
            let indexPath = IndexPath(item: self.comments.count-1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
        viewModel.deleted.bind { [weak self] (deleted, indexPath) in
            guard let self = self , let deleted = deleted, let indexPath = indexPath else { return }
            if deleted{
                self.comments.remove(at: indexPath.item)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
}

//MARK: Table View Delegate and Data Source

extension TaskDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let task = task{
            header.setupHeader(task: task)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footer.taskDetailsVC = self
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteComment(at: indexPath)
        default: ()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension TaskDetailsVC{
    
    //MARK: UI Functions
    
    private func setupTableView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinToSuperview(view)
        tableView.backgroundColor = .clear
        tableView.register(CommentCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 180
        tableView.sectionFooterHeight = 70
    }
    
    private func setupNavigation(){
        title = task?.title
        
        let leftBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarItemClicked))
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(rightBarItemClicked))
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    // MARK: Keyboard Setup Functions
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if footer.textField.isEditing {
            let keyboardHeight = getKeyboardHeight(notification)
            let tableViewContentHeight = (tableView.contentSize.height+55 < view.frame.height) ? tableView.contentSize.height+55 : view.frame.height
            if tableViewContentHeight > view.frame.height - keyboardHeight{
                let diference = tableViewContentHeight - (view.frame.height - keyboardHeight)
                view.frame.origin.y = 0 - diference
            }
        }
    }
    
    private func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    //MARK: Actions And View Model Connections
    
    func postButtonClicked(text: String){
        addComment(text: text)
    }
    
    @objc private func rightBarItemClicked(){
        let inputData = TaskInputData(
            title: header.nameTextField.text!,
            des: header.desTextField.text!,
            inReview: header.inReviewSwitch.isOn
        )
        updateTask(inputData: inputData)
    }
    
    @objc private func leftBarItemClicked(){
       viewModel.cancelButtonClicked()
    }
    
    private func addComment(text: String){
        viewModel.commentDidAdd(text: text)
    }
    
    private func deleteComment(at indexPath: IndexPath){
        viewModel.commentDidDelete(at: indexPath)
    }
    
    private func updateTask(inputData: TaskInputData){
        viewModel.taskDidUpdate(inputData: inputData)
    }
}
