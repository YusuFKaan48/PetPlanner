//
//  TaskDetailView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 10.10.2023.
//

import SwiftUI

enum TaskCellEvents {
    case onEdit
    case onCheckedChange(Task)
    case onSelect(Task)
}

struct TaskDetailView: View {
    
    let task: Task
    @State private var checked: Bool = false
    let onEvent: (TaskCellEvents) -> Void
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                }
            
            VStack(alignment: .leading) {
                Text(task.title ?? "")
               
                HStack {
                    if let taskDate = task.taskDate {
                        Text(formatDate(taskDate))
                    }
                    
                    if let taskTime = task.taskTime {
                        Text(taskTime.formatted(date: .omitted, time: .shortened))
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .onTapGesture {
                    onEvent(.onEdit)
                }
            
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(task))
            
        }
    }
}

#Preview {
    TaskDetailView(task: PreviewData.tasks, onEvent: { _ in })
}
