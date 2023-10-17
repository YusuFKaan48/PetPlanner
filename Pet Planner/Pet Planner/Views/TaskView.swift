//
//  TaskView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct TaskView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    private var taskStatBuilder = TaskStatsBuilder()
    @State private var taskStatsValues = TaskStatsValues()
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .all))
    private var allResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .allCompleted))
    private var allCompletedResults: FetchedResults<Task>
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Task")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                
                
                Text("General total.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    
                
                HStack {
                    
                    NavigationLink {
                        TaskListView(tasks: allCompletedResults)
                    } label: {
                        TaskStatView( title: "done", count: taskStatsValues.allCompletedCount, icon: "checkmark.circle")
                    }
                    
                    NavigationLink {
                        TaskListView(tasks: allResults)
                    } label: {
                        TaskStatView( title: "undone", count: taskStatsValues.allCount, icon: "circle")
                    }

                }.padding(12)
                .onAppear {
                    taskStatsValues = taskStatBuilder.build(myListResults: myListResults)
                }
                
                Text("Tasks.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                  
                
                TaskListView(tasks: allResults).padding(.trailing, 20)
               
            }
        }
    }
}

#Preview {
    TaskView()
}

