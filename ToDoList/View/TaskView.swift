//
//  ContentView.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @StateObject var viewModel: TaskViewModel
    
    @State private var showAddTask = false
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("TASKS")) {
                    if viewModel.todoTask.isEmpty {
                        Text("No tasks to do!")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(viewModel.todoTask) { task in
                            TaskRowView(task: task) { taskToComplete in
                                viewModel.completeTask(taskToComplete)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let taskToDelete = viewModel.todoTask[index]
                                viewModel.deleteTask(taskToDelete)
                            }
                        }
                    }

                }
                
                if !viewModel.completedTask.isEmpty {
                    Section(header: Text("Completed")) {
                        ForEach(viewModel.completedTask) { task in
                            TaskRowView(task: task) { taskToComplete in
                                viewModel.completeTask(taskToComplete) // Assuming this exists
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let taskToDelete = viewModel.completedTask[index]
                                viewModel.deleteTask(taskToDelete)
                            }
                        }
                    }
                } else {
                    Section(header: Text("Completed")) {
                        Text("No tasks completed yet.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Spacer()
                    Button {
                        showAddTask = true
                    } label: {
                        Label("Add trip", systemImage: "plus")
                    }
                }
            }
        }.sheet(isPresented: $showAddTask) {
            NavigationStack {
                AddTaskView(viewModel: viewModel)
            }
            .presentationDetents([.large])
        }
    }
}

#Preview {
    let mockDataManager = PreviewTaskDataManager()
    let viewModel = TaskViewModel(taskDataManager: mockDataManager)
    
    return TaskView(viewModel: viewModel)
}
