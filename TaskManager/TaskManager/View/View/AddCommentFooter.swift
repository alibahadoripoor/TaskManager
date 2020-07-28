//
//  AddCommentFooter.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class AddCommentFooter: UIView {
    
    weak var taskDetailsVC: TaskDetailsVC!
    
    let textField = UITextField()
    private let postButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .systemBackground
        
        textField.placeholder = "Add Comment"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 20
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        postButton.setTitle("Post", for: .normal)
        postButton.titleLabel?.font = .systemFont(ofSize: 20)
        postButton.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy(){
        addSubview(textField)
        addSubview(postButton)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            //text field layouts
            textField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            textField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            //post button layouts
            postButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            postButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            postButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            postButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            postButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func postButtonClicked(){
        textField.resignFirstResponder()
        taskDetailsVC.postButtonClicked(text: textField.text!)
        textField.text = ""
    }
}
