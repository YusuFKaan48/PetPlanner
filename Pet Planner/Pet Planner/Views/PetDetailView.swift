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
  
    
    init(animal: Animals) {
        self.animal = animal
        _taskResults = FetchRequest(fetchRequest: AnimalService.getTasksByList(animal: animal))
    }
    
    var body: some View {
        VStack {
            
            if let imageData = animal.picture {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .cornerRadius(125)
            } else {
        }
            Text("\(animal.name ?? "Unknown")")
                .fontWeight(.semibold)
                .font(.title)
                .padding()
            
            
            
            
            
            
            if !taskResults.isEmpty {
                Text("\(animal.name ?? "Unknown")'s Tasks.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(.horizontal, 20)
                .padding(.bottom, -6)
                .padding(.top, 24)
              
                TaskListView(tasks: taskResults).padding(.trailing, 20)
           
            }  else {
                Text("\(animal.name ?? "Unknown")'s Tasks.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -6)
                    .padding(.top, 24)
                
                
                Text("\(animal.name ?? "Unknown")'s has no tasks.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                    .padding(.top, 12)
                
                Spacer()
            }
            
        
            
            
            HStack {
                Button("+ New Task") {
                    isPresented = true
                }
            }.font(.system(size: 16))
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(8)
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
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
        
        
        Button("Delete Animal") {
                            isConfirmingDelete = true
             }.padding(.bottom,20)
            .foregroundStyle(.red)
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
}



#Preview {
    PetDetailView(animal: PreviewData.animals)
}

