//
//  Untitled.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 21/3/2568 BE.
//

import Testing
import Foundation
@testable import ToDoList


struct TaskViewModelTests {
    var mockDataManager: MockTaskDataManager!
    var viewModel: TaskViewModel!
    
    var mockTasks: [Task] = [
        Task(title: "Buy coffee", createdAt: Date(), dueDate: Date().addingTimeInterval(86400))
    ]
    
    init() throws {
        mockDataManager = MockTaskDataManager()
        viewModel = TaskViewModel(taskDataManager: mockDataManager)
    }
    
    @Test func testLoadTodos() throws {
        viewModel.addTask(title: "New Task1", dueDate: Date().addingTimeInterval(3600))
        viewModel.addTask(title: "New Task2", dueDate: Date().addingTimeInterval(3600))
        viewModel.loadTasks()
        #expect(viewModel.tasks.count == 2)
    }
    
    @Test func testAddTodo() throws {
        viewModel.addTask(title: "New Task", dueDate: Date().addingTimeInterval(3600))
        #expect(viewModel.tasks.count == 1)
        #expect(viewModel.tasks.first?.title == "New Task")
    }
    
    @Test func testToggleComplete() throws {
        let task = Task(title: "Buy coffee", createdAt: Date(), dueDate: Date().addingTimeInterval(86400))
        mockDataManager.tasks = [task]
        viewModel.completeTask(task)
        #expect(viewModel.tasks.first?.isComplete == true)
    }
    
    @Test func testDeleteTodo() throws {
        let task = Task(title: "Buy coffee", createdAt: Date(), dueDate: Date().addingTimeInterval(86400))
        mockDataManager.tasks = [task]
        viewModel.loadTasks()
        #expect(viewModel.tasks.count == 1)
        viewModel.deleteTask(task)
        #expect(viewModel.tasks.isEmpty)
    }
}
