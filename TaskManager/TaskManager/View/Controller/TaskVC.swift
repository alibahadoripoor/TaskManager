//
//  TaskTableViewController.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class TaskVC: UIViewController {
    
    var viewModel: TaskListViewModel!
    
    private let cellId = "cellId"
    private var tasks: [TaskViewModel] = []
    private let tableView = UITableView()
    private let footerView = AddFooterView()
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        setupFooterView()

        viewModel.viewDidLoad()
        
        //Notifications from View model
        
        viewModel.cells.bind { [weak self] (tasks) in
            guard let self = self else { return }
            self.tasks = tasks
            self.tableView.reloadData()
        }
        
        viewModel.newTask.bind { [weak self] (task) in
            guard let self = self, let task = task else { return }
            self.tasks.insert(task, at: 0)
            self.tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
        }
        
        viewModel.deleted.bind { [weak self] (deleted, indexPath) in
            guard let self = self , let deleted = deleted, let indexPath = indexPath else { return }
            if deleted{
                self.tasks.remove(at: indexPath.item)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}

//MARK: Table View Delegate and Data Source

extension TaskVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskCell
        cell.task = tasks[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.taskDidSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteTask(at: indexPath)
        default: ()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension TaskVC{
    
    //MARK: UI Functions
    
    private func setupTableView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinToSuperview(view, with: -70)
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10
    }
    
    private func setupNavigation(){
        title = "Task"
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func setupFooterView(){
        view.addSubview(footerView)
        footerView.pinToBottomOfSuperview(view, height: 70)
        footerView.taskVC = self
        footerView.setTitle(title: "Add New Task")
    }
    
    //MARK: Actions And View Model Connections
    
    func addButtonClicked(){
        presentNewTaskAlert()
    }

    private func presentNewTaskAlert() {
        let alert = UIAlertController(title: "New Task", message: "Enter a name for this task", preferredStyle: .alert)

        // Create actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let self = self else { return }
            if let title = alert.textFields?.first?.text, let des = alert.textFields?[1].text {
                self.addTask(title: title, des: des)
            }
        }
        saveAction.isEnabled = false

        // Add text fields
        alert.addTextField { textField in
            textField.placeholder = "Task Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Description"
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func addTask(title: String, des: String){
        let inputData = TaskInputData(title: title, des: des, inReview: false)
        viewModel.taskDidAdd(inputData: inputData)
    }
    
    private func deleteTask(at indexPath: IndexPath){
        viewModel.taskDidDelete(at: indexPath)
    }
    
    func reloadTasks(){
        viewModel.viewDidLoad()
    }
}
