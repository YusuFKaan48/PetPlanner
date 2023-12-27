//
//  TaskEditView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 11.10.2023.
//

import SwiftUI

struct TaskEditView: View {
    
    let trashIcon = UIImage(named: "trash")
    
    @Environment(\.dismiss) private var dismiss
    @Binding var task: Task
    @State var editConfig: TaskEditConfig = TaskEditConfig()
    @State private var isConfirmingDelete: Bool = false
    
    let emptyIcon = UIImage(named: "Empty")
    
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
       
        
        NavigationView {
           
            VStack {
                ScrollView {
                    HStack(spacing: 8) {
                    if let imageData = task.animals?.picture,
                       let animalName = task.animals?.name {
                        Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .cornerRadius(125)
                        Text(animalName).fontWeight(.semibold).foregroundColor(Color.black)
                    } else {
                        Image(uiImage: emptyIcon!)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .cornerRadius(36)
                        Text(task.animals?.name ?? "name").fontWeight(.semibold).foregroundColor(Color.black)
                    }
              
                    
                    Spacer()
                    
                    Button {
                        isConfirmingDelete = true
                    } label: {
                        Image(uiImage: trashIcon!)
                            
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .alert(isPresented: $isConfirmingDelete) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("This action cannot be reversed"),
                            primaryButton: .destructive(Text("Delete")) {
                                do {
                                    try AnimalService.deleteTask(task)
                                    dismiss()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }.padding(.horizontal,24)
                    .padding(.bottom, 24)
                    .padding(.top, 24)
                
                Text("Task Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                
                Text("Task Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
                TextField("New task...", text: $editConfig.title).padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        
                            .frame( height: 50)
                    )
                
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                
                Text("Task Notes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
                TextField("Add notes...", text: $editConfig.notes ?? "").padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        
                            .frame( height: 50)
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 14)
    
                Divider().padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    
                
                Text("Task Time Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                
                Toggle(isOn: $editConfig.hasDate) {
                    Text("Select Date")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }.padding(.horizontal, 24).padding(.vertical, 12)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 24)
                    
                    DatePicker("", selection: $editConfig.taskDate ?? Date(), displayedComponents: .date).padding(.trailing, 24).padding(.vertical, 12)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .disabled(!editConfig.hasDate)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                )
                .padding(.horizontal, 24)
                
                Toggle(isOn: $editConfig.hasTime) {
                    Text("Select Time")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }.padding(.horizontal, 24).padding(.vertical, 12)
            
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 20)
                    
                    DatePicker("", selection: $editConfig.taskTime ?? Date(), displayedComponents: .hourAndMinute).padding(.trailing, 24).padding(.vertical, 12)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .disabled(!editConfig.hasTime)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                )
                .padding(.horizontal, 24)
                
                Button() {
                    do {
                        let updated = try AnimalService.updateTask(task: task, editConfig: editConfig)
                            if updated {
                                if task.taskDate != nil || task.taskTime != nil {
                                    let userData = UserData(title: task.title, body: task.notes, date: task.taskDate, time: task.taskTime)
                                    NotificationManager.scheduleNotification(userData: userData)
                                }
                            }
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
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 12)
                .foregroundColor(.white)
                .disabled(!isFormValid)
            }.onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7))
            .onAppear {
                editConfig = TaskEditConfig(task: task)
            }
        }
    }
    }
}
