//
//  Pet_Planner.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.11.2023.
//

import Foundation
import SwiftUI

@main
struct Pet_PlannerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext).preferredColorScheme(.light)
        }
    }
}


