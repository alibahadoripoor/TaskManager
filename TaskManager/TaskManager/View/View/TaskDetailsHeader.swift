//
//  TaskDetailsCell.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit

final class TaskDetailsHeader: UIView {
    let nameTextField = UITextField()
    let desTextField = UITextField()
    let inReviewSwitch = UISwitch()
    private let inReviewLable = UILabel()
    private let dateLable = UILabel()
    private let sepratorLineView = UIView()
    private let vStackView = UIStackView()
    private let hStackView = UIStackView()
    
    func setupHeader(task: TaskViewModel){
        nameTextField.text = task.title
        desTextField.text = task.des
        inReviewSwitch.isOn = task.inReview
        dateLable.text = task.date
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .systemBackground
        
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        hStackView.axis = .horizontal
        
        nameTextField.placeholder = "Name"
        nameTextField.font = .boldSystemFont(ofSize: 24)
        
        desTextField.placeholder = "Description"
        desTextField.font = .systemFont(ofSize: 22)
        
        inReviewLable.text = "Review"
        inReviewLable.font = .systemFont(ofSize: 22)
        
        dateLable.font = .systemFont(ofSize: 20)
        
        sepratorLineView.backgroundColor = .systemGray4
        sepratorLineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy(){
        addSubview(vStackView)
        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(desTextField)
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(dateLable)
        hStackView.addArrangedSubview(inReviewLable)
        hStackView.addArrangedSubview(inReviewSwitch)
        addSubview(sepratorLineView)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            vStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            vStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sepratorLineView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            sepratorLineView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            sepratorLineView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            sepratorLineView.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
}
