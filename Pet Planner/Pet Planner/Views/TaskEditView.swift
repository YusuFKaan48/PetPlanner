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
                    HStack {
                        
                        Text(task.animals!.name!).fontWeight(.semibold)
                        
                        Image(systemName: "info.circle.fill").foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8))
                    }.foregroundStyle(.black)
                }.font(.system(size: 16))
                    .frame( maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
                    )
                    .frame(width: 158, height: 70)
                    .foregroundColor(Color.black).padding(.bottom, 20)
                
                   
                        TextField("Title", text: $editConfig.title).padding(.horizontal, 20)
                
                Divider().padding(.horizontal, 20)
                        
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.horizontal, 20)
                        }.padding(.horizontal, 20).padding(.vertical, 10)
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.taskDate ?? Date(), displayedComponents: .date).padding(.horizontal, 20).padding(.bottom, 10)
                        }
                
                Divider().padding(.horizontal, 20)
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.horizontal, 20)
                        }.padding(.horizontal, 20).padding(.vertical, 10)
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.taskTime ?? Date(), displayedComponents: .hourAndMinute).padding(.horizontal, 20).padding(.bottom, 10)
                        }
                    
                Divider().padding(.horizontal, 20)
                    
    

                   
                    
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
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 136)
                    .padding(.top, 20)
                    .foregroundColor(.white)
                    .disabled(!isFormValid)
                    
                    
                    
                    
                }
                

            }.accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8))
        .onAppear {
                editConfig = TaskEditConfig(task: task)
            }
            }
        }



struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: .constant(PreviewData.tasks))
    }
}

