//
//  CommentViewModel.swift
//  TaskManager
//
//  Created by Ali Bahadori on 25.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import Foundation

final class CommentViewModel {
    let text: String
    
    init(comment: Comment) {
        self.text = comment.text!
    }
}
