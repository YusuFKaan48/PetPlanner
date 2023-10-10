//
//  PetDetailView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct PetDetailView: View {
    
    let animal: Animals
    @State private var openAddTask: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var taskResults: FetchedResults<Task>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(animal: Animals) {
        self.animal = animal
        _taskResults = FetchRequest(fetchRequest: AnimalService.getTasksByList(animal: animal))
    }
    
    
    var body: some View {
        VStack {
            Text("Pet Name: \(animal.name ?? "Unknown")")
                .font(.title)
                .padding()

    
            TaskListView(tasks: taskResults)
            
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Task") {
                    openAddTask = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
        }.alert("New Task", isPresented: $openAddTask) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                if isFormValid {
                    do {
                        try AnimalService.saveTaskToMyAnimal(animal: animal, taskTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    PetDetailView(animal: Animals())
}

