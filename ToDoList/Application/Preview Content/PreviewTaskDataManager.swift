//
//  PreviewTaskDataManager.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 21/3/2568 BE.
//

import Foundation


class PreviewTaskDataManager: TaskDataManager {
    
    var mockTasks: [Task] = [
        Task(title: "Buy coffee", createdAt: Date(), dueDate: nil),
        Task(title: "Finish project", createdAt: Date(), dueDate: Date().addingTimeInterval(86400)),
        Task(title: "Buy ticket", createdAt: Date(), dueDate: Date().addingTimeInterval(36000), isComplete: true),
    ]

    func fetchAllTasks() throws -> [Task] {
        return mockTasks
    }
    
    func saveTask(title: String, createdAt: Date, dueDate: Date?) throws {
        let newTask = Task(title: title, createdAt: createdAt, dueDate: dueDate)
        mockTasks.append(newTask)
    }
    
    func completeTask(task: Task) throws {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            mockTasks[index].isComplete.toggle()
        }
    }
    
    func deleteTask(task: Task) throws {
        mockTasks.removeAll { $0.id == task.id }
    }
    
    func updateTask(task: Task) throws { }
}
