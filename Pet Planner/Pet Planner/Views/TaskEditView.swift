//
//  TaskEditView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 11.10.2023.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var task: Task
    @State var editConfig: TaskEditConfig = TaskEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.taskDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.taskTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectPetView(selectedPet: $task.animals)
                        } label: {
                            HStack {
                                Text("Pets")
                                Spacer()
                                Text(task.animals!.name!)
                            }
                        }

                    }
                }
                .listStyle(.insetGrouped)

            }.onAppear {
                editConfig = TaskEditConfig(task: task)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Task")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                            do {
                              let _ = try AnimalService.updateTask(task: task, editConfig: editConfig)
                            } catch {
                                print(error)
                            }
                        dismiss()
                    }.disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView(task: .constant(PreviewData.tasks))
    }
}

