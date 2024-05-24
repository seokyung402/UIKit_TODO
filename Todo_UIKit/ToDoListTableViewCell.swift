//
//  ToDoListTableViewCell.swift
//  Todo_UIKit
//
//  Created by seokyung on 5/24/24.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    private lazy var todoText: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "TodoThings"
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textLabel
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private var todo: Todo?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(doneButton)
        contentView.addSubview(todoText)
        
        doneButton.addAction(UIAction { [weak self] _ in
            guard let self = self, let todo = self.todo else { return }
            todo.doneTodo.toggle()
            self.updateButtonImage()
            SharedData.shared.saveTodoData()  // 상태 변경 후 저장
            print("\(todo.todoText), \(todo.doneTodo)")
        }, for: .touchUpInside)
        
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        todoText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 40),
            
            todoText.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            todoText.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 20),
            todoText.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(todo: Todo) {
        self.todo = todo
        todoText.text = todo.todoText
        updateButtonImage()
    }
    
    private func updateButtonImage() {
        guard let todo = todo else { return }
        let imageName = todo.doneTodo ? "checkmark.square.fill" : "square"
        doneButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
