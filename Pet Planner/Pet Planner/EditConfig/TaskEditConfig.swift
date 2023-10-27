//
//  TaskEditConfig.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 11.10.2023.
//

import Foundation

struct TaskEditConfig {
    var title: String = ""
    var isDone: Bool = false
    var notes: String?
    var hasDate: Bool = false
    var hasTime: Bool = false
    var taskDate: Date?
    var taskTime: Date?
    
    init() { }
    
    init(task: Task) {
        title = task.title ?? ""
        isDone = task.isDone
        notes = task.notes ?? ""
        taskDate = task.taskDate ?? Date()
        taskTime = task.taskTime ?? Date()
        hasDate = task.taskDate != nil
        hasTime = task.taskTime != nil
    }
}

