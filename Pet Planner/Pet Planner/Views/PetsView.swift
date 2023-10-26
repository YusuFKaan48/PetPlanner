//
//  PetsView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct PetsView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    @FetchRequest(sortDescriptors: [])
    private var myAnimalResults: FetchedResults<Animals>
    
    private var taskStatBuilder = TaskStatsBuilder()
    @State private var taskStatsValues = TaskStatsValues()
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .all))
    private var allResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .allCompleted))
    private var allCompletedResults: FetchedResults<Task>
    
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Pets")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                
                if myAnimalResults.isEmpty {
                    Text("No pets here...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                        .padding(.vertical, 24)
                } else {
                    
                    VStack() {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){ ForEach(myAnimalResults, id: \.self) { animal in
                            NavigationLink(destination: PetDetailView(animal: animal)) {
                                let animalUncompletedTasks = allResults.filter { $0.animals == animal }
                               
                                    
                                    HStack {
                                        if let imageData = animal.picture {
                                            Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 36, height: 36)
                                                .cornerRadius(25)
                                        } else {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                                .cornerRadius(25)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(animal.name ?? "Unknown")
                                                .font(.system(size: 16))
                                                .foregroundColor(.black)
                                                .fontWeight(.medium)

                                            Text("Have a: \(animalUncompletedTasks.count) task")
                                                .font(.system(size: 14))
                                                .foregroundColor(.black.opacity(0.5))
                                        }

                                      
                                    }
                                    .frame(width: 166, height: 70)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
                                    )
                                    .foregroundColor(Color.black)
                            }.padding(.bottom, 16)
                            }
                        }
                    }.padding(.horizontal, 12)
                    
                }
            }
            
                Text("General total.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                
                HStack {
                    NavigationLink {
                        TaskListView(tasks: allCompletedResults)
                    } label: {
                        TaskStatView( title: "done", count: taskStatsValues.allCompletedCount, icon: "checkmark.circle")
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        TaskListView(tasks: allResults)
                    } label: {
                        TaskStatView( title: "undone", count: taskStatsValues.allCount, icon: "circle")
                    }

                }.padding(.horizontal, 20)
                .onAppear {
                    taskStatsValues = taskStatBuilder.build(myListResults: myListResults)
                }
             
                
            if !allResults.isEmpty {
                Text("Task list.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -6)
                    .padding(.top, 24)
                  
                TaskListView(tasks: allResults).padding(.trailing, 20)
            } else {
                Text("Task list.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -6)
                    .padding(.top, 24)
                
                Text("There is nothing we can do.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                    .padding(.top, 12)
                Spacer()
            }
              
            
            
            
            Button {
                isPresented = true
            } label: {
                Text("+ Add New Pets")
                    .font(.system(size: 16))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(8)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddPetView { name, picture  in
                    do {
                        let imageData = picture?.jpegData(compressionQuality: 0.8)
                        try AnimalService.saveAnimal(name, picture: imageData)
                    } catch {
                        print(error)
                    }
                }
            }
        }
            
            }
        }



#Preview {
    PetsView()
}

