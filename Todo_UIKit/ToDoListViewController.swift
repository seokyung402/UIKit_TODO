//
//  ViewController.swift
//  Todo_UIKit
//
//  Created by seokyung on 5/24/24.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTodoControllerDelegate {
    
    var todoDatas = TodoDatas()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.wantsDateDecorations = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedData.shared.loadTodoData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        view.addSubview(dateView)
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            dateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            dateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            dateView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        
        navigationItem.title = "ToDo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTodo))

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SharedData.shared.numberOfTodo()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoListTableViewCell
        let todos = SharedData.shared.getAllTodos()//해당 데이터 가져오고
        let todo = todos[indexPath.row]
        cell.configureCell(todo: todo)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70 //cell의 크기 지정, 셀의 크기가 넓어짐
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SharedData.shared.removeTodo(index: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @objc func addTodo() {
        let addTodoViewController = AddToDoViewController()
        let navigationController = UINavigationController(rootViewController: addTodoViewController)
        addTodoViewController.delegate = self
        present(navigationController, animated: true)
    }
    
    public func saveTodos(_ todo: Todo) {
        SharedData.shared.addTodo(newTodo: todo)
        tableView.reloadData()
    }
    
}

