//
//  SharedData.swift
//  Todo_UIKit
//
//  Created by seokyung on 5/24/24.
//

import Foundation
import UIKit

class SharedData {
    static let shared = SharedData()
    private var todos: [Todo]
    
    private init() {
        todos = []
    }
    
    func numberOfTodo() -> Int {
        todos.count
    }
    
    func getTodo(index: Int) -> Todo {
        todos[index]
    }
    
    func getAllTodos() -> [Todo] {
        let readOnlyTodos = todos
        return readOnlyTodos
    }
    
    func addTodo(newTodo: Todo) {
        todos.append(newTodo)
        saveTodoData()
    }
    
    func removeTodo(index: Int) {
        todos.remove(at: index)
        saveTodoData()
    }
    
    func getDocumentDirectory() -> URL { //document 디렉토리 경로를 가져옴
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        // 대부분의 경우 앱은 하나의 Document 디렉토리만을 사용하므로, paths[0]은 보통 유일한 Document 디렉토리의 URL을 반환
    }
    //사용자의 일지 데이터를 저장할 디렉토리의 경로를 가져오는 것으로, 이후에 이 디렉토리에 일지 데이터를 저장하거나 불러올 때 사용
    
    func loadTodoData() {
        let pathDirectory = getDocumentDirectory() //디렉토리 경로 가져오고
        let fileURL = pathDirectory.appendingPathComponent("todosData.json") //journalEntriesData.json 파일의 URL을 생성
        do {// 모든 파일액세스에서는 do-catch 구문이 들어감
            let data = try Data(contentsOf: fileURL)
            let todosData = try JSONDecoder().decode([Todo].self, from: data) //JSON 데이터를 JournalEntry 배열로 디코딩
            // 여기서 self는 해당 메서드가 호출된 현재 객체
            todos = todosData
            // 디코딩된 데이터를 journalEntries 배열에 저장
        } catch {
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
    
    func saveTodoData() {
        let pathDirectory = getDocumentDirectory()
        // 만약에 있으면 안 만들어서 옵셔널 트라이임
        try? FileManager.default.createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let filePath = pathDirectory.appendingPathComponent("todosData.json")
        let json = try? JSONEncoder().encode(todos)
        do {
            try json!.write(to: filePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
        
    }
}
