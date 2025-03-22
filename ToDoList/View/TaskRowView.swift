//
//  TaskListItem.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 20/3/2568 BE.
//

import SwiftUI

struct TaskRowView: View {
    @State var task: Task
    var onComplete: (Task) -> Void

    var body: some View {
        HStack {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isComplete ? .green : .gray)
                .onTapGesture {
                    onComplete(task)
                }
            VStack(alignment: .leading) {
                Text(task.title)
                if let date = task.dueDate {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
        }
    }
}

#Preview {
    TaskRowView(task: Task(title: "Sample Task", createdAt: Date(), dueDate: Date().addingTimeInterval(3600))) { _ in }
}
