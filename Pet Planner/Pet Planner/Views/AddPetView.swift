//
//  AddPetView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import SwiftUI
import Photos

struct AddPetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var photoLibraryPermissionRequested: Bool = false
    
    let onSave: (String, UIImage?) -> Void
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
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
                            if PHPhotoLibrary.authorizationStatus() == .authorized {
                                isImagePickerPresented = true
                            } else {
                                print("Photo Library access denied or not determined.")
                            }
                        }
                }
            }.padding(.bottom, 24)
            
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
                ImagePicker(selectedImage: $selectedImage)
            }
            
            Text("What's your pet's name?")
                .fontWeight(.medium)
                .padding(.bottom, 12)
            
            TextField("Pet's name", text: $name).padding(.horizontal, 24)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.sRGB, red: 242/255, green: 242/255, blue: 242/255, opacity: 1.0))
                        .frame(height: 50)
                )
                .padding(24)
            
            Spacer()
            
            Button {
                onSave(name, selectedImage)
                print("Save button tapped")
                
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
            .padding(.bottom, 24)
            .foregroundColor(.white)
            .disabled(!isFormValid)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .padding(.top, 160)
        .onAppear {
            requestPhotoLibraryPermission()
        }
        .onChange(of: selectedImage) { oldImage, newImage in
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
