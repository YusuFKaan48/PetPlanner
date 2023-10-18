//
//  NewTaskView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 18.10.2023.
//

import SwiftUI

struct NewTaskView: View {
    
    @State private var title: String = ""
    
    let onSave: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        VStack {
            Text("Add new task.")
                .fontWeight(.bold)
            
            TextField("New task", text: $title)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.none)
            
            Button {
                    onSave(title)
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
            .padding(.horizontal, 120)
            .padding(.top, 20)
            .foregroundColor(.white)
            .disabled(!isFormValid)
        }
        .padding()
    }
}

#Preview {
    NewTaskView(onSave: { (_) in })
}
