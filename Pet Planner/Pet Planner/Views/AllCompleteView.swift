//
//  AllCompleteView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 13.12.2023.
//

import SwiftUI

struct AllCompleteView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .all))
    private var allResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .allCompleted))
    private var allCompletedResults: FetchedResults<Task>
    
    var body: some View {
        ScrollView {
            TaskListView(tasks: allCompletedResults)
        }
    }
}

#Preview {
    AllCompleteView()
}
