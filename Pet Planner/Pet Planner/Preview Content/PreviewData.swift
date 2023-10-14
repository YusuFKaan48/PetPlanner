//
//  PreviewData.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 10.10.2023.
//

import Foundation
import CoreData

class PreviewData {
    
    static var tasks: Task {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Task.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Task(context: viewContext)
    }
    
    
    static var animals: Animals {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Animals.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Animals()
    }
    
}
