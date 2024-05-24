//
//  Todo.swift
//  Todo_UIKit
//
//  Created by seokyung on 5/24/24.
//

import Foundation
import UIKit

class Todo: NSObject, Codable {
    let todoText: String
    var doneTodo: Bool
    
    init(todoText: String, doneTodo: Bool) {
        self.todoText = todoText
        self.doneTodo = false
    }
}

struct TodoDatas {
    var todos: [Todo] = []
}
