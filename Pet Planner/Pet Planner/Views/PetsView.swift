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
                
                
                if myAnimalResults.isEmpty {
                    Text("No pets available")
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(myAnimalResults, id: \.self) { animal in
                                NavigationLink(destination: PetDetailView(animal: animal)) {
                                    Text(animal.name ?? "empty")
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.gray, lineWidth: 1)
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
                }
                .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
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
