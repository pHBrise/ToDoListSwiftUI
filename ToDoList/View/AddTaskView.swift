//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 19/3/2568 BE.
//

import SwiftUI
import WidgetKit

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.calendar) private var calendar
    @Environment(\.timeZone) private var timeZone
    @ObservedObject var viewModel: TaskViewModel
    @State private var title: String = ""
    @State private var dueDate: Date? = nil
    @State private var isDate: Bool = false
    @State private var showDatePicker: Bool = false
    @FocusState private var isTitleFocused: Bool
    
    var dateRange: ClosedRange<Date> {
        let start = Date.now
        let components = DateComponents(calendar: calendar, timeZone: timeZone, year: 2)
        let end = calendar.date(byAdding: components, to: start)!
        return start...end
    }
    
    var body: some View {
        Form {
            Section(header: Text("NEW TASK")) {
                Group {
                    TextField("Enter a title for your task", text: $title)
                        .focused($isTitleFocused)
                    Toggle(isOn: Binding(
                        get: { isDate },
                        set: { newValue in
                            isDate = newValue
                            showDatePicker = isDate
                            isTitleFocused = false
                            if !newValue { dueDate = nil } else {
                                dueDate = Date()
                            }
                        }
                    )) {
                        Button(action: {
                            showDatePicker.toggle()
                            if showDatePicker {
                                isTitleFocused = false
                            }
                        }) {
                            HStack {
                                HStack {
                                    Image(systemName: "calendar").foregroundStyle(.red)
                                    if let date = dueDate {
                                        Text("Date: \(formattedDate(date))")
                                    } else {
                                        Text("Date")
                                    }
                                }
                            }
                        }
                        .disabled(!isDate)
                    }
                    .toggleStyle(SwitchToggleStyle())
                    
                    if showDatePicker {
                        DatePicker("Select Date", selection: Binding(
                            get: { dueDate ?? Date() },
                            set: { dueDate = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: isDate)
                    }
                }
            }
        }
        .onChange(of: isTitleFocused, { oldValue, newValue in
            if newValue {
                showDatePicker = false
            }
        })
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    addTrip()
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
    }
    
    private func addTrip() {
        withAnimation {
            viewModel.addTask(title: title, dueDate: dueDate)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}

#Preview {
    let mockDataManager = PreviewTaskDataManager()
    let viewModel = TaskViewModel(taskDataManager: mockDataManager)
    
    return AddTaskView(viewModel: viewModel)
}
