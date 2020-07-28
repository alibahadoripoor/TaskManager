//
//  TaskTableViewCell.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    var task: TaskViewModel?{
        didSet{
            guard let task = task else { return }
            textLabel?.text = task.title
            detailTextLabel?.text = task.des
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
    }
    
}
