//
//  SelectPetView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 13.10.2023.
//


import SwiftUI

struct SelectPetView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myAnimalsFetchResults: FetchedResults<Animals>
    @Binding var selectedPet: Animals?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(myAnimalsFetchResults, id: \.self) { animals in
                    HStack {
                        Text(animals.name!)
                            .onTapGesture {
                                self.selectedPet = animals
                            }
                        if selectedPet == animals {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .font(.system(size: 16))
                    .frame(height: 70)
                    .frame( maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1) .frame(width: 158, height: 70)
                    )
                    .foregroundColor(Color.black)
                }
            }.padding(.vertical, 6)
        }.padding(6)
    }
}







#Preview {
    SelectPetView(selectedPet: .constant(PreviewData.animals))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
