//
//  PetsView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.10.2023.
//

import SwiftUI

struct PetsView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myAnimalResults: FetchedResults<Animals>
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pets")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                
                
                if myAnimalResults.isEmpty {
                    Text("No pets available")
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(myAnimalResults, id: \.self) { animal in
                                NavigationLink(destination: PetDetailView(animal: animal)) {
                                    Text(animal.name ?? "empty")
                                        .font(.system(size: 16))
                                        .frame( maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
                                        )
                                        .padding(6)
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                    }
                }
                
                Button {
                    isPresented = true
                } label: {
                    Text("+ Add New Pets")
                        .font(.system(size: 16))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 1.0), Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.50)]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(12)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddPetView { name in
                        do {
                            try AnimalService.saveAnimal(name)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PetsView().environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
