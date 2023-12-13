//
//  TodayCompleteView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 13.12.2023.
//


import SwiftUI

struct TodayCompleteView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .today))
    private var todayResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .todayCompleted))
    private var todayCompletedResults: FetchedResults<Task>
    
    var body: some View {
        ScrollView {
            TaskListView(tasks: todayCompletedResults)
        }
    }
}

#Preview {
    TodayCompleteView()
}
