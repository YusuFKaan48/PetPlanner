//
//  TaskListView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct TaskListView: View {
    
    let tasks: FetchedResults<Task>
    @State private var selectedTask: Task?
    @State private var showTaskDetail: Bool = false
    
    private func taskCheckedChanged(task: Task, isDone: Bool) {
        var editConfig = TaskEditConfig(task: task)
        editConfig.isDone = isDone
        
        do {
            let _ = try AnimalService.updateTask(task: task, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isTaskSelected(_ task: Task) -> Bool {
        selectedTask?.objectID == task.objectID
    }
    
    private func deleteTask(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let task = tasks[index]
            do {
                try AnimalService.deleteTask(task)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            if tasks.isEmpty {
                Text("There are no tasks.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                    .padding(.top, 12)
            } else {
                LazyVStack {
                    ForEach(tasks) { task in
                        TaskDetailView(task: task, isSelected: isTaskSelected(task)) { event in
                            switch event {
                            case .onSelect(let task):
                                selectedTask = task
                            case .onCheckedChange(let task, let isDone):
                                taskCheckedChanged(task: task, isDone: isDone)
                            case .onEdit:
                                showTaskDetail = true
                            }
                        }
                        Divider()
                    }
                }
            }
        }
        .sheet(isPresented: $showTaskDetail) {
            TaskEditView(task: Binding($selectedTask)!)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        
        @FetchRequest(sortDescriptors: [])
        private var taskResults: FetchedResults<Task>
        
        var body: some View {
            TaskListView(tasks: taskResults)
        }
    }
    
    static var previews: some View {

        TaskListViewContainer()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
