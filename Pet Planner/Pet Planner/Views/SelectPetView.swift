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
                ForEach(myAnimalsFetchResults, id: \.self) { animal in
                 
                        HStack {
                            if let imageData = animal.picture {
                                 Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "photo")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 36)
                                    .cornerRadius(25)
                                    .padding(.leading, 16)
                            }
                            
                            Text(animal.name!).font(.system(size: 16))
                                .frame(maxWidth: .infinity, minHeight: 70, maxHeight: 70)
                                .fontWeight(.semibold)
                                .onTapGesture {
                                    self.selectedPet = animal
                                }
                                if selectedPet == animal {
                                    Image(systemName: "checkmark.circle").foregroundStyle((Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.7)))
                                    
                                }
                        
                         Spacer()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
                        )
                        .padding(6)
                        .foregroundColor(Color.black)
                    }
                
            }
            .padding(.vertical, 6)
        }
        .padding(6)
    }
}

struct SelectPetView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPetView(selectedPet: .constant(PreviewData.animals))
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}


