//
//  TaskDetailView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 10.10.2023.
//

import SwiftUI

enum TaskCellEvents {
    case onEdit
    case onCheckedChange(Task, Bool)
    case onSelect(Task)
}

struct TaskDetailView: View {
    
    let task: Task
    let delay = Delay()
    let isSelected: Bool
    let infoIcon = UIImage(named: "info-circle")
    let circleIcon = UIImage(named: "circle")
    let checkCircleIcon = UIImage(named: "check-circle")
    
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
            
            Image(uiImage: checked ? checkCircleIcon! : circleIcon!)
                .onTapGesture {
                    checked.toggle()
                    
                    delay.cancel()
                    
                    delay.performWork {
                        onEvent(.onCheckedChange(task, checked))
                    }
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title ?? "").font(.system(size: 16))
                
                if let notes = task.notes, !notes.isEmpty {
                    Text(notes).font(.system(size: 14)).opacity(0.8)
                }
            }
        
                
                VStack(alignment: .trailing, spacing: 4) {
                    
                    Image(uiImage: infoIcon!)
                        .opacity(isSelected ? 1.0: 0.0)
                        .onTapGesture {
                            onEvent(.onEdit)
                        }
                        .onAppear {
                            checked = task.isDone
                        }
                    
                HStack {
                    if let taskDate = task.taskDate {
                        Text(formatDate(taskDate)).font(.system(size: 12))
                    }
                    
                    if let taskTime = task.taskTime {
                        Text(taskTime.formatted(date: .omitted, time: .shortened)).font(.system(size: 12))
                    }
                    
                }.frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.caption)
                    .opacity(0.4)
                    
                  
                    
                }
                    
            
           
            
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(task))
        }
    }
}


