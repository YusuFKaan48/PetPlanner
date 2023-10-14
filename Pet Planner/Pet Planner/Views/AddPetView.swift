//
//  AddPetView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import SwiftUI

struct AddPetView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    
    let onSave: (String) -> Void
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack {
            Text("What's your pet name ?")
                .fontWeight(.bold)
                
            
            Text("Please enter your pet's name.")
                .foregroundColor(.gray)
            
            TextField("Pet's Name", text: $name)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.none)
            
            
            Button {
                onSave(name)
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
    AddPetView(onSave: { (_) in } )
}
