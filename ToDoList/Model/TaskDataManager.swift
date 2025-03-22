//
//  TaskDataManager.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import Foundation
import SwiftData

protocol TaskDataManager {
    func fetchAllTasks() throws -> [Task]
    func saveTask(title: String, createdAt: Date, dueDate: Date?) throws
    func completeTask(task: Task) throws
    func deleteTask(task: Task) throws
}

class RealTaskDataManager: TaskDataManager {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAllTasks() throws -> [Task] {
        let descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
    
    func saveTask(title: String, createdAt: Date, dueDate: Date?) throws {
        let newTask = Task(title: title, createdAt: createdAt, dueDate: dueDate)
        modelContext.insert(newTask)
        try modelContext.save()
    }
    
    func completeTask(task: Task) throws {
        task.isComplete.toggle()
        try modelContext.save()
    }
    
    func deleteTask(task: Task) throws {
        modelContext.delete(task)
        try modelContext.save()
    }

}
