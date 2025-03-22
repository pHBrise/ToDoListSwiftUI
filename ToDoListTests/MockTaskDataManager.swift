//
//  MockTaskDataManager.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 21/3/2568 BE.
//
@testable import ToDoList
import Foundation

class MockTaskDataManager: TaskDataManager {
    var tasks: [Task]
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    func fetchAllTasks() throws -> [Task] {
        return tasks
    }
    
    func saveTask(title: String, createdAt: Date, dueDate: Date?) throws {
        let newTask = Task(title: title, createdAt: createdAt, dueDate: dueDate)
        tasks.append(newTask)
    }
    
    func completeTask(task: Task) throws {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isComplete.toggle()
        }
    }
    
    func deleteTask(task: Task) throws {
        tasks.removeAll { $0.id == task.id }
    }
    
    func updateTask(task: Task) throws {
    }
}
