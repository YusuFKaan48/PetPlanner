//
//  HomeView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    private var taskStatBuilder = TaskStatsBuilder()
    @State private var taskStatsValues = TaskStatsValues()
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .today))
    private var todayResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .todayCompleted))
    private var todayCompletedResults: FetchedResults<Task>
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Today's total.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                
                HStack {
                    NavigationLink {
                        TaskListView(tasks: todayCompletedResults)
                    } label: {
                        TaskStatView( title: "done", count: taskStatsValues.todaysCompletedCount)
                    }
                    
                    NavigationLink {
                        TaskListView(tasks: todayResults)
                    } label: {
                        TaskStatView( title: "undone", count: taskStatsValues.todayCount)
                    }
                    
                }.onAppear {
                    taskStatsValues = taskStatBuilder.build(myListResults: myListResults)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
