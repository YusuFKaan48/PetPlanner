//
//  HomeView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<Animals>
    
    private var taskStatBuilder = TaskStatsBuilder()
    @State private var taskStatsValues = TaskStatsValues()
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .today))
    private var todayResults: FetchedResults<Task>
    
    @FetchRequest(fetchRequest: AnimalService.tasksByStatType(statType: .todayCompleted))
    private var todayCompletedResults: FetchedResults<Task>
    

    
    
    var body: some View {
        NavigationStack {
           
            VStack {
               
                
                Text("Home")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    
                    
               
                if !todayResults.isEmpty {
                    Text("Today's have a task.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        
                        
                        
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 32) {
                            ForEach(Array(myListResults.filter { animal in
                                !todayResults.filter { $0.animals == animal }.isEmpty
                            }), id: \.self) { animal in
                                NavigationLink(destination: PetDetailView(animal: animal)) {
                                    VStack(alignment: .center) {
                                        if let imageData = animal.picture {
                                            Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 56, height: 56)
                                                .cornerRadius(36)
                                        } else {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 56, height: 56)
                                                .cornerRadius(36)
                                        }
                                        VStack(alignment: .center) {
                                            Text(animal.name ?? "Unknown")
                                                .font(.system(size: 16))
                                                .foregroundColor(.black)
                                                .fontWeight(.medium)
                                        }
                                    }
                                    .foregroundColor(Color.black)
                                }
                            }
                        }
                        .padding(.leading, 24)
                        
                        .frame(height: 90)
                    }

                        
                }  else {
                    
                    Text("Today's have a task.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 24)
                        .padding(.bottom, -6)
                        .padding(.top, 24)
                        
                    
                    
                    
                    Text("Where did the animals go?")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                        .padding(.vertical, 12)
                }
                
                Text("Today's total.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
                HStack(spacing: 16) {
                    NavigationLink {
                        TaskListView(tasks: todayCompletedResults).padding(.trailing, 24)
                    } label: {
                        TaskStatView( title: "done", count: taskStatsValues.todaysCompletedCount, icon: "checkmark.circle")
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        TaskListView(tasks: todayResults).padding(.trailing, 24)
                    } label: {
                        TaskStatView( title: "undone", count: taskStatsValues.todayCount, icon: "circle")
                    }
                }.padding(.horizontal, 24)
                    .onAppear {
                    taskStatsValues = taskStatBuilder.build(myListResults: myListResults)
                }
                
                
                if !todayResults.isEmpty {
                Text("Daily task list.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 24)
                    .padding(.bottom, -6)
                    .padding(.top, 24)
                  
                    TaskListView(tasks: todayResults).padding(.trailing, 24)
               
                }  else {
                    Text("Daily task list.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 24)
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
            }
        }
        }
    }

#Preview {
    HomeView()
}
