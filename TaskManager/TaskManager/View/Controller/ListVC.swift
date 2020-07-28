//
//  Project.swift
//  TaskManager
//
//  Created by Ali Bahadori on 20.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {
    
    private let cellId = "cellId"
    
    private var cells: [String] = []
    
    private let tableView = UITableView()
    private let footerView = AddFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        setupFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}

extension ProjectVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.textLabel?.text = cells[indexPath.item]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskTVC = TaskTableViewController()
        navigationController?.pushViewController(taskTVC, animated: true)
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
    private func setupTableView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.pinToSuperview(view)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
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
        footerView.parentVC = self
    }
    
    func addButtonClicked(){
        presentNewProjectAlert()
    }
    
    private func addProject(name: String){
        cells.insert(name, at: 0)
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
    
    private func deleteProject(at indexPath: IndexPath){
        cells.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .fade)
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
}
