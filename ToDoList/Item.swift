//
//  Item.swift
//  ToDoList
//
//  Created by Phanvit Chevamongkolnimit on 15/3/2568 BE.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
