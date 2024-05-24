//
//  AddToDoViewController.swift
//  Todo_UIKit
//
//  Created by seokyung on 5/24/24.
//

import UIKit

protocol AddTodoControllerDelegate: NSObject {
    func saveTodos(_ todo: Todo)
}

class AddToDoViewController: UIViewController {
    weak var delegate: AddTodoControllerDelegate?
    
    private lazy var todoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What To Do Today"
        textField.borderStyle = .roundedRect

        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add ToDo"
        view.backgroundColor = .white
        view.addSubview(todoTextField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTodo))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTodo))
        
        todoTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todoTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            todoTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func saveTodo() {
        guard let text = todoTextField.text, !text.isEmpty else { return }
        
        let todo = Todo(todoText: text, doneTodo: false)
        delegate?.saveTodos(todo)
        dismiss(animated: true)
    }
    
    @objc func cancelTodo() {
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
