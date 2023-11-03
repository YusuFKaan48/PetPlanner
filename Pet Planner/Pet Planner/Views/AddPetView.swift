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
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    let onSave: (String, UIImage?) -> Void

    private var isFormValid: Bool {
        !name.isEmpty
    }

    var body: some View {
        ScrollView {
        VStack {
            ZStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .cornerRadius(60)
                } else {
                    Circle()
                        .foregroundStyle(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 48))
                                .foregroundColor(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0))
                            
                            
                        )
                        .onTapGesture {
                            isImagePickerPresented = true
                        }
                }
            }.padding(.bottom, 20)

            Button {
                isImagePickerPresented = true
            } label: {
                EmptyView()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }

            Text("What's your pet's name?")
                .fontWeight(.medium)
                .padding(.bottom, 10)


            
            
            
            TextField("Pet's name", text: $name).padding(.horizontal, 20)
                .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                    
                    .frame( height: 50)
            )
            
            .padding(20)
            
            
         Spacer()
            
            Button {
                onSave(name, selectedImage)
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
            .padding(.bottom, 20)
            .foregroundColor(.white)
            .disabled(!isFormValid)
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .padding(.top, 160)
        .onChange(of: selectedImage) { newImage in
            if newImage != nil {
                isImagePickerPresented = false
            }
        }
            
        }
        
    }
}
