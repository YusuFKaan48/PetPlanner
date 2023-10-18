//
//  PetDetailView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct PetDetailView: View {
    
    let animal: Animals
    @State private var isPresented: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var taskResults: FetchedResults<Task>
    
    init(animal: Animals) {
        self.animal = animal
        _taskResults = FetchRequest(fetchRequest: AnimalService.getTasksByList(animal: animal))
    }
    
    
    var body: some View {
        VStack {
            Text("\(animal.name ?? "Unknown")")
                .fontWeight(.semibold)
                .font(.title)
                .padding()
            
            Text("\(animal.name ?? "Unknown")'s Tasks.")
                .frame(maxWidth: .infinity, alignment: .leading)
            
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(.horizontal, 20)
            
            TaskListView(tasks: taskResults).padding(.trailing, 20)
            
            HStack {
                Button("+ New Task") {
                    isPresented = true
                }
            }.font(.system(size: 16))
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(12)
        .foregroundColor(.white)
        .padding(.horizontal, 20)
    }.sheet(isPresented: $isPresented) {
        NavigationView {
            NewTaskView { title in
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
    PetDetailView(animal: PreviewData.animals)
}

