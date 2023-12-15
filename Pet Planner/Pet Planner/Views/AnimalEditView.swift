//
//  AnimalEditView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 27.10.2023.
//

import SwiftUI
import Photos

struct AnimalEditView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myAnimalResults: FetchedResults<Animals>
    
    
    @Binding var animals: Animals
    let animal: Animals
    
    @State private var selectedImageData: Data?
    @State private var isImagePickerPresented: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State var editConfig: AnimalEditConfig = AnimalEditConfig()
    @State private var photoLibraryPermissionRequested: Bool = false
    
    
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
                    .padding(.horizontal, 24)
                
                Text("Update the picture")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
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
                                if PHPhotoLibrary.authorizationStatus() == .authorized {
                                    isImagePickerPresented = true
                                } else {
                                    print("Photo Library access denied or not determined.")
                                }
                            }
                    }
                    
                    Button {
                        if PHPhotoLibrary.authorizationStatus() == .authorized {
                            isImagePickerPresented = true
                        } else {
                            print("Photo Library access denied or not determined.")
                        }
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
                }.padding(.bottom, 24)
                
                Text("Update the name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                
                TextField("Pet's name", text: $editConfig.name)
                    .padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                            .frame(height: 50)
                    )
                    .padding(24)
                
                Button {
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
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .disabled(!isFormValid)
            }
        }
        .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7))
        .onAppear {
            editConfig = AnimalEditConfig(animals: animals)
        }
        .onAppear {
            requestPhotoLibraryPermission()
        }
        .onChange(of: selectedImageData) { _, newImage in
            if newImage != nil {
                isImagePickerPresented = false
            } else {
                isImagePickerPresented = true
            }
        }
    }
    
    private func requestPhotoLibraryPermission() {
        if !photoLibraryPermissionRequested {
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("Photo Library access authorized")
                case .denied, .restricted:
                    print("Photo Library access denied or restricted")
                case .notDetermined:
                    print("Photo Library access not determined")
                case .limited:
                    print("Photo Library access not determined")
                @unknown default:
                    break
                }
            }
            photoLibraryPermissionRequested = true
            
        }
    }
}
