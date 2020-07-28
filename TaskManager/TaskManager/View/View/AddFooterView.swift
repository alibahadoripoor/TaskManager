//
//  AddFooterView.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class AddFooterView: UIView {
    
    weak var projectVC: ProjectVC?
    weak var taskVC: TaskVC?
    
    private let addButton = UIButton(type: .system)
    
    func setTitle(title: String){
        addButton.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupAddButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAddButton(){
        addSubview(addButton)
        
        addButton.backgroundColor = .systemGray5
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        addButton.contentMode = .scaleAspectFit
        addButton.layer.cornerRadius = 7
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func addButtonClicked(){
        if projectVC != nil{
            projectVC!.addButtonClicked()
        }
        if taskVC != nil{
            taskVC!.addButtonClicked()
        }
    }
}
