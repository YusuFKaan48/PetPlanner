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
            
            Button("Save") {
                onSave(name)
                dismiss()
            }.buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .padding(.top, 20)
                .disabled(!isFormValid)
        }
        .padding()
    }
}


#Preview {
    AddPetView(onSave: { (_) in } )
}
