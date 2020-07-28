//
//  Project.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {
    
    var viewModel: ProjectListViewModel!
    
    private var projects: [ProjectViewModel] = []
    private let cellId = "cellId"
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

        viewModel.cells.bind { [weak self] (projects) in
            guard let self = self else { return }
            self.projects = projects
            self.tableView.reloadData()
        }
        
        viewModel.newProject.bind { [weak self] (project) in
            guard let self = self, let project = project else { return }
            self.projects.insert(project, at: 0)
            self.tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
        }
        
        viewModel.deleted.bind { [weak self] (deleted, indexPath) in
            guard let self = self, let deleted = deleted, let indexPath = indexPath else { return }
            if deleted{
                self.projects.remove(at: indexPath.item)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}

//MARK: Table View Delegate and Data Source

extension ProjectVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProjectCell
        cell.project = projects[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.projectDidSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteProject(at: indexPath)
        default: ()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension ProjectVC{
    
    //MARK: UI Functions
    
    private func setupTableView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinToSuperview(view, with: -70)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10
    }
    
    private func setupNavigation(){
        title = "Project"
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func setupFooterView(){
        view.addSubview(footerView)
        footerView.pinToBottomOfSuperview(view, height: 70)
        footerView.projectVC = self
        footerView.setTitle(title: "Add New Project")
    }
    
    //MARK: Actions
    
    func addButtonClicked(){
        presentNewProjectAlert()
    }
    
    private func presentNewProjectAlert() {
        let alert = UIAlertController(title: "New Project", message: "Enter a name for this project", preferredStyle: .alert)

        // Create actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addProject(name: name)
            }
        }
        saveAction.isEnabled = false

        // Add a text field
        alert.addTextField { textField in
            textField.placeholder = "Project Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: View Model Connections
    
    private func addProject(name: String){
        viewModel.projectDidAdd(name: name)
    }
    
    private func deleteProject(at indexPath: IndexPath){
        viewModel.projectDidDelete(at: indexPath)
    }
}
