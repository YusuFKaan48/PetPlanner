//
//  CoreDataProvider.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import Foundation
import CoreData

class CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "AnimalsModel")
        
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error initializing AnimalModel: \(error), \(error.userInfo)")
            } else {
                print("Core Data initialized successfully")
            }
        }
    }
}


