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
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .all))
    private var allResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .allCompleted))
    private var allCompletedResults: FetchedResults<Task>
    
    @Environment(\.dismiss) private var dismiss
    @State private var isConfirmingDelete: Bool = false
    @State private var editConfig = TaskEditConfig()
    
    @State private var isEditViewPresented: Bool = false
    @State private var editAnimal: Animals = Animals()
    
    init(animal: Animals) {
        self.animal = animal
        self.editAnimal = animal
        _taskResults = FetchRequest(fetchRequest: AnimalService.getTasksByList(animal: animal))
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                if let imageData = animal.picture {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .cornerRadius(125)
                        .padding(.trailing, 8)
                }
                
                Text("\(animal.name ?? "Unknown")")
                    .fontWeight(.semibold)
                    .font(.title)
                
                Button {
                    isEditViewPresented = true
                    editAnimal = animal
                } label: {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                .sheet(isPresented: $isEditViewPresented) {
                    AnimalEditView(animals: $editAnimal, animal: editAnimal)
                }
                Spacer()
                
                Button {
                    isConfirmingDelete = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                }
                .buttonStyle(BorderlessButtonStyle())
                .alert(isPresented: $isConfirmingDelete) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("This action cannot be reversed"),
                        primaryButton: .destructive(Text("Delete")) {
                            do {
                                try AnimalService.deleteAnimal(animal)
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding(.horizontal, 24)
            
            Text("\(animal.name ?? "Unknown")'s Tasks.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(.horizontal, 24)
                .padding(.top, 12)
            
            ScrollView {
                VStack {
                    if !taskResults.isEmpty {
                        
                        TaskListView(tasks: taskResults).padding(.horizontal, 24).padding(.top, 8)
                    }  else {
                        Image(uiImage: UIImage(named: "Play") ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Text("\(animal.name ?? "Unknown")'s has no tasks.")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                            .padding(.top, 12)
                        
                        Spacer()
                    }
                }
            }
            
            HStack {
                NavigationLink(destination: NewTaskView { title, date, time, notes in
                    do {
                        try AnimalService.saveTaskToMyAnimal(animal: animal, taskNotes: notes, taskTitle: title, taskDate: date, taskTime: time)
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("+ New Task")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            }
        }
    }
}
