//
//  NewTaskView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 18.10.2023.
//

import SwiftUI

struct NewTaskView: View {
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var notes: String = ""
    @State private var time: Date = Date()
    @State private var isDateEnabled: Bool = false
    @State private var isTimeEnabled: Bool = false
    
    let onSave: (String, Date?, Date?, String?) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
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
                
                TextField("New Task...", text: $title).padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                            .frame( height: 50)
                    ).padding(.horizontal, 24)
                    .padding(.vertical, 12)
                
                Text("Please do not leave the name field empty.")
                    .fontWeight(.medium)
                    .font(.system(size: 12))
                    .foregroundColor(.black).opacity(0.3)
                    .padding(.top, 4)
                
                Text("Task Notes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
                TextField("Add note...", text: $notes).padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                            .frame( height: 50)
                    ).padding(.horizontal, 24)
                    .padding(.vertical, 12)
                
                Divider().padding(24)
                
                Text("Task Time Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                
                Toggle(isOn: $isDateEnabled) {
                    Text("Select Date")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }.padding(.horizontal, 24).padding(.vertical, 12)
            
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 24)
                    
                    DatePicker("", selection: $date, displayedComponents: .date).padding(.trailing, 24).padding(.vertical, 12)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .disabled(!isDateEnabled)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                )
                .padding(.horizontal, 24)
            
                Toggle(isOn: $isTimeEnabled) {
                    Text("Select Time")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }.padding(.horizontal, 24).padding(.vertical, 12)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8)).padding(.leading, 24)
                    
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute).padding(.trailing, 24).padding(.vertical, 12)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .disabled(!isTimeEnabled)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                )
                .padding(.horizontal, 24)
        
                Button {
                    onSave(title, isDateEnabled ? date : nil, isTimeEnabled ? time : nil, notes)
                    let userData = UserData(title: title, body: notes, date: isDateEnabled ? date : nil, time: isTimeEnabled ? time : nil)
                    NotificationManager.scheduleNotification(userData: userData)
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
                .padding(.top, 12)
                .foregroundColor(.white)
                .disabled(!isFormValid)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

#Preview {
    NewTaskView(onSave: { (_,_,_,_) in })
}
