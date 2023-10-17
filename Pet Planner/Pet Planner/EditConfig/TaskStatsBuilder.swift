//
//  TaskStatsBuilder.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 16.10.2023.
//

import Foundation
import SwiftUI

enum TaskStatType {
    case today
    case todayCompleted
    case all
    case allCompleted
}

struct TaskStatsValues {
    var todayCount: Int = 0
    var todaysCompletedCount: Int = 0
    var allCount: Int = 0
    var allCompletedCount: Int = 0
}

struct TaskStatsBuilder {
    
    func build(myListResults: FetchedResults<Animals>) -> TaskStatsValues {
        
        let tasksArray = myListResults.compactMap {
                $0.tasks?.allObjects as? [Task]
        }.reduce([], +)
           
        let todaysCount = calculateTodaysCount(tasks: tasksArray)
        let todaysCompletedCount = calculateTodaysCompletedCount(tasks: tasksArray)
        let allCount = calculateAllCount(tasks: tasksArray)
        let allCompletedCount = calculateCompletedCount(tasks: tasksArray)
        
        return TaskStatsValues(todayCount: todaysCount, todaysCompletedCount: todaysCompletedCount, allCount: allCount, allCompletedCount: allCompletedCount)
    }
    
    private func calculateTodaysCount(tasks: [Task]) -> Int {
        return tasks.reduce(0) { result, task in
            let isToday = task.taskDate?.isToday ?? false
            return isToday ? result + 1: result
        }
    }
    
    private func calculateTodaysCompletedCount(tasks: [Task]) -> Int {
        return tasks.reduce(0) { result, task in
            if task.isDone && task.taskDate?.isToday ?? false {
                return result + 1
            }
            return result
        }
    }
    
    private func calculateCompletedCount(tasks: [Task]) -> Int {
        return tasks.reduce(0) { result, task in
            return task.isDone ? result + 1 : result
        }
    }
    
    private func calculateAllCount(tasks: [Task]) -> Int {
        return tasks.reduce(0) { result, task in
            return !task.isDone ? result + 1 : result
        }
    }
}

