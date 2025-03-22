//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import SwiftUI
import SwiftData
import Foundation

class TaskViewModel: ObservableObject {
    @State private var showAlert = false
    private var taskDataManager: TaskDataManager
    
    @Published var tasks: [Task] = []
    @Published var error: Error?
    
    var todoTask: [Task] {
        tasks.filter { !$0.isComplete }
    }
    
    var completedTask: [Task] {
        tasks.filter { $0.isComplete }
    }
    
    init(taskDataManager: TaskDataManager) {
        self.taskDataManager = taskDataManager
        loadTasks()
    }
    
    func loadTasks() {
        do {
            tasks = try taskDataManager.fetchAllTasks()
        } catch {
            self.error = error
            print("Error loading todos: \(error)")
        }
    }
    
    func addTask(title: String, dueDate: Date?) {
        do {
            try taskDataManager.saveTask(title: title, createdAt: Date(), dueDate: dueDate)
            loadTasks()
        } catch {
            self.error = error
            print("Error loading todos: \(error)")
        }
    }
    
    func completeTask(_ task: Task) {
        do {
            try taskDataManager.completeTask(task: task)
            loadTasks()
        } catch {
            self.error = error
            print("Error loading todos: \(error)")
        }
    }
    
    func deleteTask(_ task: Task) {
        do {
            try taskDataManager.deleteTask(task: task)
        } catch {
            self.error = error
            print("Error deleting todo: \(error)")
        }
        loadTasks()
    }
}
