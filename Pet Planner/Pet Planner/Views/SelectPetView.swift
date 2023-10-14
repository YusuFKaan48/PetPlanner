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
        List(myAnimalsFetchResults) { animals in
            HStack {
                HStack {
                    Text(animals.name!)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedPet = animals
                }
                
                Spacer()
                
                if selectedPet == animals {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}



#Preview {
    SelectPetView(selectedPet: .constant(PreviewData.animals))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
