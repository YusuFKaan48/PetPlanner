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
            Text("Home")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.horizontal, 24)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if !todayResults.isEmpty {
                        Text("Today's Have a Task")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.horizontal, 24)
                            .padding(.top, 12)
                    
                        ScrollView(.horizontal, showsIndicators: false) {
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
                                                    .frame(width: 64, height: 64)
                                                    .cornerRadius(36)
                                            } else {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .frame(width: 64, height: 64)
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
                            .padding(.horizontal, 24)
                            .frame(height: 90)
                        }
                    }  else {
                        
                        Text("Today's Have a Task")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.horizontal, 24)
                            .padding(.top, 12)
                        
                        Image(uiImage: UIImage(named: "Animal") ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            

                        
                        Text("Where did the animals go?")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                    }
                    
                    if !todayResults.isEmpty {
                        HStack(alignment: .bottom) {
                        Text("Daily Task List")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            
                            
                            
                            NavigationLink {
                                TodayCompleteView().padding(.horizontal, 24)
                            } label: {
                                TaskStatView( title: "Completed Tasks", count: taskStatsValues.todaysCompletedCount, icon: "checkmark.circle")
                            }.opacity(0.8)
                        }.padding(.leading, 24)
                            .padding(.trailing, 16)
                            .padding(.top, 24)
                        
                        TaskListView(tasks: todayResults).padding(.horizontal, 24).padding(.top, 8)
                        
                    }  else {
                        HStack(alignment: .bottom) {
                        Text("Daily Task List")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            
                            
                            
                            NavigationLink {
                                TodayCompleteView().padding(.horizontal, 24)
                            } label: {
                                TaskStatView( title: "Completed Tasks", count: taskStatsValues.todaysCompletedCount, icon: "checkmark.circle")
                            }.opacity(0.8)
                        }.padding(.leading, 24)
                            .padding(.trailing, 16)
                            .padding(.top, 24)
                        
                        Image(uiImage: UIImage(named: "Bored") ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)

                        
                        Text("There is nothing we can do.")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor((Color(.sRGB, red: 210/255, green: 211/255, blue: 213/255, opacity: 1.0)))
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
