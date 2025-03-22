//
//  Item.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import Foundation
import SwiftData

@Model
final class Task {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var dueDate: Date?
    var title: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), title:String, createdAt: Date, dueDate: Date?, isComplete: Bool = false) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}
