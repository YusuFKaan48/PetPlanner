//
//  TodayUncompleteView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 13.12.2023.
//

import SwiftUI

struct TodayUncompleteView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .today))
    private var todayResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .todayCompleted))
    private var todayCompletedResults: FetchedResults<Task>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TaskListView(tasks: todayResults)
        }
    }
}

#Preview {
    TodayUncompleteView()
}
