//
//  TableViewCell.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class ProjectCell: UITableViewCell {
    
    var project: ProjectViewModel?{
        didSet{
            guard let project = project else { return }
            self.textLabel?.text = project.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
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
