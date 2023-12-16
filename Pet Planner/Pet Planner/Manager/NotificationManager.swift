//
//  NotificationManager.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 16.12.2023.
//

import Foundation
import UserNotifications

struct UserData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
}

class NotificationManager {
    
    static func scheduleNotification(userData: UserData) {
        
        let content = UNMutableNotificationContent()

            if let taskTitle = userData.title, !taskTitle.isEmpty {
                content.title = "Pet Planner"
                
                if let notes = userData.body, !notes.isEmpty {
                    content.body = "\(taskTitle) (\(notes))"
                } else {
                    content.body = taskTitle
                }
            } 
        

    
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        if let taskTime = userData.time {
            let taskTimeDateComponents = taskTime.dateComponents
            dateComponents.hour = taskTimeDateComponents.hour
            dateComponents.minute = taskTimeDateComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
}

