//
//  TaskEditView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 11.10.2023.
//

import SwiftUI

struct TaskEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var task: Task
    @State var editConfig: TaskEditConfig = TaskEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    SelectPetView(selectedPet: $task.animals)
                } label: {
                 
                        
                        
                        
                        
                        
                        
                    HStack(spacing: 8) {
                        if let imageData = task.animals?.picture {
                            Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .cornerRadius(25)
                        }
                        
                        Text(task.animals!.name!).fontWeight(.semibold).foregroundColor(Color.black)
                        
                       
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7))
                        Spacer()
                    }.padding(.horizontal,20)
                        .padding(.bottom, 20)

                        
                        
                   
                }
                
                
                
                Text("Task Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    
                
                Text("Task Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                TextField("New task...", text: $editConfig.title).padding(.horizontal, 20)
                    .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        
                        .frame( height: 50)
                )
                
                .padding(20)
                
                Text("Task Notes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                TextField("Add notes...", text: $editConfig.notes ?? "").padding(.horizontal, 20)
                    .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        
                        .frame( height: 50)
                )
                
                .padding(20)
                
                
                
                
                Divider().padding(20)
                
                
                
                
                
                Text("Task Time Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    
                
                
                
               
                
                
               
                
                Toggle(isOn: $editConfig.hasDate) {
                  Text("Select Date")
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .font(.system(size: 14))
                      .fontWeight(.regular)
                }.padding(.horizontal, 20).padding(.vertical, 10)
              
              
              
              
             
              HStack {
                  Image(systemName: "calendar")
                      .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 20)
                  
                  DatePicker("", selection: $editConfig.taskDate ?? Date(), displayedComponents: .date).padding(.trailing, 20).padding(.vertical, 10)
                      .foregroundColor(.gray)
                      .font(.system(size: 12))
                      .disabled(!editConfig.hasDate)
                      
              }
              .background(
                  RoundedRectangle(cornerRadius: 8)
                      .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
              )
              .padding(.horizontal, 20)
          
              
             
                
                
                
                
                
                
            
                
            
                  Toggle(isOn: $editConfig.hasTime) {
                    Text("Select Time")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                  }.padding(.horizontal, 20).padding(.vertical, 10)
                
                
                
                
            
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 20)
                    
                    DatePicker("", selection: $editConfig.taskTime ?? Date(), displayedComponents: .hourAndMinute).padding(.trailing, 20).padding(.vertical, 10)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .disabled(!editConfig.hasTime)
                        
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                )
                .padding(.horizontal, 20)
            
                
               
                
                
                
                
                
                Button() {
                    do {
                        let _ = try AnimalService.updateTask(task: task, editConfig: editConfig)
                    } catch {
                        print(error)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .foregroundColor(.white)
                .disabled(!isFormValid)
            }
        }
        .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7))
        .onAppear {
            editConfig = TaskEditConfig(task: task)
        }
    }
}
