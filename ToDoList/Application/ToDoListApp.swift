//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        let taskDataManager = RealTaskDataManager(modelContext: sharedModelContainer.mainContext)
        WindowGroup {
            TaskView(viewModel: TaskViewModel(taskDataManager: taskDataManager))
        }
        .modelContainer(sharedModelContainer)
    }
}

#Preview {
    let mockDataManager = PreviewTaskDataManager()
    let viewModel = TaskViewModel(taskDataManager: mockDataManager)
    
    return TaskView(viewModel: viewModel)
}
