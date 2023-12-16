//
//  Pet_Planner.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 9.11.2023.
//

import Foundation
import SwiftUI
import UserNotifications

@main
struct Pet_PlannerApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Allowed")
            } else {
                print("Don't allowed")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext).preferredColorScheme(.light)
        }
    }
}


