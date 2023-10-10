//
//  AnimalService.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import Foundation
import CoreData

class AnimalService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveAnimal(_ name: String) throws {
        let animal = Animals(context: viewContext)
        animal.name = name
        try save()
    }
    
    static func saveTaskToMyAnimal(animal: Animals, taskTitle: String) throws {
        let task = Task(context: viewContext)
        task.title = taskTitle
        animal.addToTasks(task)
        try save()
    }
    
    static func getTasksByList(animal: Animals) -> NSFetchRequest<Task> {
        let request = Task.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "animals == %@ AND isDone == false", animal)
        return request
    }

}

