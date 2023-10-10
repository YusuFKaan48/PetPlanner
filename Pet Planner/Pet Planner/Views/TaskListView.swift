//
//  TaskListView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct TaskListView: View {
    
    let tasks: FetchedResults<Task>
    
    var body: some View {
        List(tasks) { task in
            Text(task.title ?? "")
        }
    }
}

/*
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
} */

