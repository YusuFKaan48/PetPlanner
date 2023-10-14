//
//  TaskListView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct TaskListView: View {
    
    let tasks: FetchedResults<Task>
    
    private func taskCheckedChanged(task: Task) {
        var editConfig = TaskEditConfig(task: task)
        editConfig.isDone = !task.isDone
        
        do {
            let _ = try AnimalService.updateTask(task: task, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(tasks) { task in
            TaskDetailView(task: task) { event in
                switch event {
                    case .onSelect(let task):
                        print("onSelect")
                    case .onCheckedChange(let task):
                     taskCheckedChanged(task: task)
                    case .onEdit:
                        print("onEdit")
                }
                
            }
        }
        .listStyle(PlainListStyle()) 
    }
}



/*
 #Preview {  
        TaskListView()
} */

