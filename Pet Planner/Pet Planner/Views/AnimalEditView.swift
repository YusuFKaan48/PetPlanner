//
//  AnimalEditView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 27.10.2023.
//

import SwiftUI

struct AnimalEditView: View {
    
    @Binding var animals: Animals
    let animal: Animals
    
    @State private var selectedImageData: Data?
    @State private var isImagePickerPresented: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State var editConfig: AnimalEditConfig = AnimalEditConfig()
    
    
    private var isFormValid: Bool {
        !editConfig.name.isEmpty
    }
    
    var body: some View {
        NavigationView {
            
                VStack {
                    Text("Pet Details")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                    
                    Text("Animals picture")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    ZStack {
                        if let selectedImageData = selectedImageData, let image = UIImage(data: selectedImageData) {
                            Image(uiImage: image)
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
                        
                        Button {
                            isImagePickerPresented = true
                        } label: {
                            EmptyView()
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: Binding(get: {
                                UIImage(data: selectedImageData ?? Data())
                            }, set: { newImage in
                                selectedImageData = newImage?.pngData()
                                isImagePickerPresented = false
                            }))
                        }
                    }.padding(.bottom, 20)
                    
                    Text("Animals name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    TextField("Pet's name", text: $editConfig.name)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                                .frame(height: 50)
                        )
                        .padding(20)
                    
                    Button() {
                        if let selectedImageData = selectedImageData {
                            editConfig.picture = selectedImageData
                        }
                        do {
                            let _ = try AnimalService.updateAnimal(animals: animals, editConfig: editConfig)
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
                    .foregroundColor(.white)
                    .disabled(!isFormValid)
                }
            }
            .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7))
            .onAppear {
                editConfig = AnimalEditConfig(animals: animals)
            }
        
    }
}
