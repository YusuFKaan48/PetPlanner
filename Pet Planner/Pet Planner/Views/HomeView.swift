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
                    .padding(.horizontal, 20)
                    
               
                if !todayResults.isEmpty {
                    Text("Today's have a task.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                        .padding(.bottom, -6)
                        .padding(.top, 24)
                        
                        
                  

                    ScrollView(.horizontal) {
                        HStack {
                            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                                ForEach(myListResults) { animal in
                                    let animalUncompletedTasks = todayResults.filter { $0.animals == animal }
                                    if !animalUncompletedTasks.isEmpty {
                                        VStack {
                                            Text(animal.name ?? "Unknown")
                                                .font(.system(size: 16))
                                                .foregroundColor(.black)
                                                .fontWeight(.medium)

                                            Text("Have a: \(animalUncompletedTasks.count) task")
                                                .font(.system(size: 14))
                                                .foregroundColor(.black.opacity(0.5))
                                        }
                                        .frame(width: 158, height: 70)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
                                        )
                                        .foregroundColor(Color.black)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                       
                    }

                }

                
                Text("Today's total.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                
                HStack {
                    
                    NavigationLink {
                        TaskListView(tasks: todayCompletedResults)
                    } label: {
                        TaskStatView( title: "done", count: taskStatsValues.todaysCompletedCount, icon: "checkmark.circle")
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        TaskListView(tasks: todayResults)
                    } label: {
                        TaskStatView( title: "undone", count: taskStatsValues.todayCount, icon: "circle")
                    }
                   
                }.padding(.horizontal, 20)
                    
                    .onAppear {
                    taskStatsValues = taskStatBuilder.build(myListResults: myListResults)
                        
                }
                
                Text("Daily task list.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -6)
                    .padding(.top, 24)
                  
                
                TaskListView(tasks: todayResults).padding(.trailing, 20)
               
            }
        }
        
    }
}

#Preview {
    HomeView()
}
